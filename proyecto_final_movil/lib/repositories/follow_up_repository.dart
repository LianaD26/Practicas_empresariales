import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import '../models/follow-up_model.dart';
import '../data/local/database.dart';
import '../services/follow-up_service.dart';
import '../services/connectivity_service.dart';

class FollowUpRepository {
  final AppDatabase _db;
  final SeguimientoService _seguimientoService = SeguimientoService();
  final ConnectivityService _connectivityService = ConnectivityService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FollowUpRepository(this._db);

  SeguimientoModel _toModel(FollowUpEntry entry) {
    return SeguimientoModel(
      id: entry.id,
      fecha: entry.fecha,
      comentario: entry.comentario,
      estado: EstadoSeguimiento.fromValue(entry.estado),
      postulacionId: entry.postulacionId,
    );
  }

  FollowUpEntriesCompanion _toCompanion(SeguimientoModel model) {
    return FollowUpEntriesCompanion(
      id: Value(model.id),
      fecha: Value(model.fecha),
      comentario: Value(model.comentario),
      estado: Value(model.estado.value),
      postulacionId: Value(model.postulacionId),
    );
  }

  /// Crea un nuevo seguimiento (offline-first).
  Future<SeguimientoModel> crearSeguimiento({
    required String comentario,
    required EstadoSeguimiento estado,
    required String postulacionId,
  }) async {
    final docId = _firestore.collection('seguimientos').doc().id;

    final seguimiento = SeguimientoModel(
      id: docId,
      fecha: DateTime.now(),
      comentario: comentario,
      estado: estado,
      postulacionId: postulacionId,
    );

    // 1. Guardar local
    await _db.followUpDao.upsert(_toCompanion(seguimiento));

    // 2. Sincronizar o encolar
    if (await _connectivityService.hasConnection) {
      await _firestore.collection('seguimientos').doc(seguimiento.id).set(seguimiento.toMap());
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'create',
        entityType: 'followUp',
        entityId: seguimiento.id,
        payload: _serializeFollowUp(seguimiento),
      );
    }

    return seguimiento;
  }

  /// Observa todos los seguimientos de una postulación.
  Stream<List<SeguimientoModel>> watchSeguimientosPorPostulacion(String postulacionId) {
    _syncSeguimientosPorPostulacion(postulacionId);
    return _db.followUpDao.watchByPostulation(postulacionId).map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Observa seguimientos filtrados por estado.
  Stream<List<SeguimientoModel>> watchSeguimientosPorEstado(String postulacionId, EstadoSeguimiento estado) {
    _syncSeguimientosPorPostulacion(postulacionId);
    return _db.followUpDao.watchByPostulationAndStatus(postulacionId, estado.value).map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Actualiza los datos de un seguimiento (offline-first).
  Future<void> actualizarSeguimiento(SeguimientoModel seguimiento) async {
    // 1. Guardar local
    await _db.followUpDao.upsert(_toCompanion(seguimiento));

    // 2. Sincronizar o encolar
    if (await _connectivityService.hasConnection) {
      await _seguimientoService.actualizarSeguimiento(seguimiento);
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'update',
        entityType: 'followUp',
        entityId: seguimiento.id,
        payload: _serializeFollowUp(seguimiento),
      );
    }
  }

  /// Actualiza únicamente el estado de un seguimiento (offline-first).
  Future<void> actualizarEstado(String id, EstadoSeguimiento nuevoEstado) async {
    final local = await _db.followUpDao.getById(id);
    if (local != null) {
      final updated = _toModel(local).copyWith(estado: nuevoEstado);
      await _db.followUpDao.upsert(_toCompanion(updated));
    }

    if (await _connectivityService.hasConnection) {
      await _seguimientoService.actualizarEstado(id, nuevoEstado);
    } else {
      final payload = {
        'id': id,
        'estado': nuevoEstado.value,
      };
      await _db.pendingOperationsDao.enqueue(
        operationType: 'updateStatus',
        entityType: 'followUp',
        entityId: id,
        payload: jsonEncode(payload),
      );
    }
  }

  /// Elimina un seguimiento (offline-first).
  Future<void> eliminarSeguimiento(String id) async {
    // 1. Eliminar local
    await _db.followUpDao.deleteById(id);

    // 2. Sincronizar o encolar
    if (await _connectivityService.hasConnection) {
      await _seguimientoService.eliminarSeguimiento(id);
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'delete',
        entityType: 'followUp',
        entityId: id,
        payload: '',
      );
    }
  }

  // ================= SINCRONIZACIÓN EN SEGUNDO PLANO =================

  Future<void> _syncSeguimientosPorPostulacion(String postulacionId) async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _seguimientoService.getSeguimientosPorPostulacion(postulacionId);
        final companions = remote.map(_toCompanion).toList();
        await _db.followUpDao.upsertAll(companions);
      }
    } catch (e) {
      print('Error syncing follow-ups for application $postulacionId: $e');
    }
  }

  String _serializeFollowUp(SeguimientoModel followUp) {
    final map = {
      'id': followUp.id,
      'fecha': followUp.fecha.toIso8601String(),
      'comentario': followUp.comentario,
      'estado': followUp.estado.value,
      'postulacionId': followUp.postulacionId,
    };
    return jsonEncode(map);
  }
}
