import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import '../core/constants.dart';
import '../models/postulation_model.dart';
import '../data/local/database.dart';
import '../services/firestore_service.dart';
import '../services/connectivity_service.dart';
import '../services/permission_service.dart';

class PostulationRepository {
  final AppDatabase _db;
  final FirestoreService _firestoreService = FirestoreService();
  final ConnectivityService _connectivityService = ConnectivityService();
  final PermissionService _permissionService = PermissionService();

  PostulationRepository(this._db);

  PostulacionModel _toModel(PostulationEntry entry) {
    return PostulacionModel(
      id: entry.id,
      ofertaId: entry.ofertaId,
      studentId: entry.studentId,
      estado: PostulacionEstado.values.firstWhere(
        (e) => e.toString().split('.').last == entry.estado,
        orElse: () => PostulacionEstado.postulado,
      ),
      motivoRechazo: entry.motivoRechazo,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      syncStatus: entry.syncStatus,
    );
  }

  PostulationEntriesCompanion _toCompanion(
    PostulacionModel model, {
    String? overrideSyncStatus,
  }) {
    return PostulationEntriesCompanion(
      id: Value(model.id),
      ofertaId: Value(model.ofertaId),
      studentId: Value(model.studentId),
      estado: Value(model.estado.toString().split('.').last),
      motivoRechazo: Value(model.motivoRechazo),
      createdAt: Value(model.createdAt),
      updatedAt: Value(model.updatedAt),
      syncStatus: Value(
        overrideSyncStatus ?? model.syncStatus ?? AppStates.syncStatusSynced,
      ),
    );
  }

  /// Observa postulaciones de un estudiante.
  Stream<List<PostulacionModel>> watchApplicationsByStudent(String studentId) {
    _syncApplicationsByStudent(studentId);
    return _db.postulationDao.watchByStudent(studentId).map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Observa postulaciones para una oferta.
  Stream<List<PostulacionModel>> watchApplicationsByOffer(String offerId) {
    _syncApplicationsByOffer(offerId);
    return _db.postulationDao.watchByOffer(offerId).map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Observa todas las postulaciones (para coordinador).
  Stream<List<PostulacionModel>> watchAllApplications() {
    _syncAllApplications();
    return _db.postulationDao.watchAll().map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Obtiene una postulación por ID.
  Future<PostulacionModel?> getPostulacionById(String id) async {
    final local = await _db.postulationDao.getById(id);
    if (local != null) {
      _syncPostulacion(id);
      return _toModel(local);
    }

    if (await _connectivityService.hasConnection) {
      try {
        final remote = await _firestoreService.getPostulacionById(id);
        if (remote != null) {
          await _db.postulationDao.upsert(_toCompanion(remote));
          return remote;
        }
      } catch (e) {
        print('Error obteniendo postulación remota $id: $e');
      }
    }
    return null;
  }

  /// Verifica si un estudiante ya se postuló a una oferta.
  Future<bool> hasStudentApplied(String studentId, String offerId) async {
    final localResult =
        await _db.postulationDao.hasStudentApplied(studentId, offerId);
    if (localResult) return true;

    if (await _connectivityService.hasConnection) {
      try {
        return await _firestoreService.hasStudentApplied(studentId, offerId);
      } catch (e) {
        print('Error verificando postulación remota: $e');
      }
    }
    return false;
  }

  /// Crea o actualiza una postulación (offline-first).
  /// Retorna si quedó marcada como pendingSync.
  Future<bool> createOrUpdatePostulacion(PostulacionModel postulacion) async {
    final hasNet = await _connectivityService.hasConnection;

    if (hasNet) {
      try {
        final synced = postulacion.copyWith(
          syncStatus: AppStates.syncStatusSynced,
        );
        await _db.postulationDao.upsert(
          _toCompanion(synced, overrideSyncStatus: AppStates.syncStatusSynced),
        );
        await _firestoreService.createOrUpdatePostulacion(synced);
        return false;
      } catch (e) {
        print('Fallo guardado remoto, encolando localmente: $e');
      }
    }

    final pending = postulacion.copyWith(
      syncStatus: AppStates.syncStatusPendingSync,
    );
    await _db.postulationDao.upsert(
      _toCompanion(pending, overrideSyncStatus: AppStates.syncStatusPendingSync),
    );
    await _db.pendingOperationsDao.enqueue(
      operationType: 'createOrUpdate',
      entityType: 'postulation',
      entityId: postulacion.id,
      payload: _serializePostulacion(pending),
    );
    return true;
  }

  /// Actualiza el estado de una postulación.
  Future<bool> updateApplicationStatus(
    String applicationId,
    PostulacionEstado estado, {
    String? motivo,
  }) async {
    _permissionService.validateRejectionReason(estado, motivo);

    final local = await _db.postulationDao.getById(applicationId);
    PostulacionModel? updated;
    if (local != null) {
      updated = _toModel(local).copyWith(
        estado: estado,
        motivoRechazo: motivo,
        updatedAt: DateTime.now(),
      );
    }

    if (updated == null) {
      throw StateError('Postulación no encontrada localmente');
    }

    if (await _connectivityService.hasConnection) {
      try {
        await _db.postulationDao.upsert(
          _toCompanion(updated, overrideSyncStatus: AppStates.syncStatusSynced),
        );
        await _firestoreService.updateApplicationStatus(
          applicationId,
          estado,
          motivo: motivo,
        );
        return false;
      } catch (e) {
        print('Fallo actualización remota, encolando: $e');
      }
    }

    final pending = updated.copyWith(
      syncStatus: AppStates.syncStatusPendingSync,
    );
    await _db.postulationDao.upsert(
      _toCompanion(pending, overrideSyncStatus: AppStates.syncStatusPendingSync),
    );
    final payload = {
      'estado': estado.toString().split('.').last,
      'motivoRechazo': motivo,
    };
    await _db.pendingOperationsDao.enqueue(
      operationType: 'updateStatus',
      entityType: 'postulation',
      entityId: applicationId,
      payload: jsonEncode(payload),
    );
    return true;
  }

  // ================= SINCRONIZACIÓN EN SEGUNDO PLANO =================

  Future<void> _mergeRemotePostulations(List<PostulacionModel> remote) async {
    final pendingLocal = await _db.postulationDao.getPendingSync();
    final pendingIds = pendingLocal.map((e) => e.id).toSet();

    for (final model in remote) {
      if (!pendingIds.contains(model.id)) {
        await _db.postulationDao.upsert(_toCompanion(model));
      }
    }
  }

  Future<void> _syncApplicationsByStudent(String studentId) async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote =
            await _firestoreService.getApplicationsByStudent(studentId);
        await _mergeRemotePostulations(remote);
      }
    } catch (e) {
      print('Error syncing postulations for student $studentId: $e');
    }
  }

  Future<void> _syncApplicationsByOffer(String offerId) async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _firestoreService.getApplicationsByOffer(offerId);
        await _mergeRemotePostulations(remote);
      }
    } catch (e) {
      print('Error syncing postulations for offer $offerId: $e');
    }
  }

  Future<void> _syncAllApplications() async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _firestoreService.getAllApplications();
        await _mergeRemotePostulations(remote);
      }
    } catch (e) {
      print('Error syncing all postulations: $e');
    }
  }

  Future<void> _syncPostulacion(String id) async {
    try {
      if (await _connectivityService.hasConnection) {
        final local = await _db.postulationDao.getById(id);
        if (local != null &&
            (local.syncStatus == AppStates.syncStatusPendingSync ||
                local.syncStatus == 'pending')) {
          return;
        }
        final remote = await _firestoreService.getPostulacionById(id);
        if (remote != null) {
          await _db.postulationDao.upsert(_toCompanion(remote));
        }
      }
    } catch (e) {
      print('Error syncing postulation $id: $e');
    }
  }

  String _serializePostulacion(PostulacionModel p) {
    final map = {
      'id': p.id,
      'ofertaId': p.ofertaId,
      'studentId': p.studentId,
      'estado': p.estado.toString().split('.').last,
      'motivoRechazo': p.motivoRechazo,
      'createdAt': p.createdAt.toIso8601String(),
      'updatedAt': p.updatedAt?.toIso8601String(),
      'syncStatus': p.syncStatus,
    };
    return jsonEncode(map);
  }
}
