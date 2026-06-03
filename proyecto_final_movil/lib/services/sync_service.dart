import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/local/database.dart';
import 'connectivity_service.dart';
import 'firestore_service.dart';
import 'document_service.dart';
import 'follow-up_service.dart';
import '../models/user_model.dart';
import '../models/company_model.dart';
import '../models/offer_model.dart';
import '../models/postulation_model.dart';
import '../models/document_model.dart';
import '../models/follow-up_model.dart';

class SyncService {
  final AppDatabase _db;
  final ConnectivityService _connectivityService = ConnectivityService();
  final FirestoreService _firestoreService = FirestoreService();
  final DocumentService _documentService = DocumentService();
  final SeguimientoService _seguimientoService = SeguimientoService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<bool>? _connectivitySubscription;
  bool _isSyncing = false;

  SyncService(this._db);

  /// Inicializa la escucha de cambios de conectividad para sincronizar
  void initialize() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = _connectivityService.onConnectivityChanged.listen((hasConnection) {
      if (hasConnection) {
        syncPendingOperations();
      }
    });

    // También intentar correr una sincronización inicial al arrancar si hay red
    _connectivityService.hasConnection.then((hasConnection) {
      if (hasConnection) {
        syncPendingOperations();
      }
    });
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }

  /// Procesa todas las operaciones pendientes de la cola local.
  Future<void> syncPendingOperations() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final pendingOps = await _db.pendingOperationsDao.getUnsynced();
      if (pendingOps.isEmpty) {
        _isSyncing = false;
        return;
      }

      print('Sincronizando ${pendingOps.length} operaciones pendientes...');

      for (final op in pendingOps) {
        // Verificar conexión antes de procesar cada operación
        final hasNet = await _connectivityService.hasConnection;
        if (!hasNet) break;

        bool success = false;
        try {
          success = await _processOperation(op);
        } catch (e) {
          print('Error procesando operación pendiente (ID: ${op.id}): $e');
        }

        if (success) {
          await _db.pendingOperationsDao.markSynced(op.id);
        } else {
          await _db.pendingOperationsDao.incrementRetry(op.id);
        }
      }

      // Limpiar operaciones sincronizadas exitosamente
      await _db.pendingOperationsDao.deleteSynced();
    } catch (e) {
      print('Error general en la sincronización: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> _processOperation(PendingOperationEntry op) async {
    switch (op.entityType) {
      case 'user':
        return await _syncUserOperation(op);
      case 'company':
        return await _syncCompanyOperation(op);
      case 'offer':
        return await _syncOfferOperation(op);
      case 'postulation':
        return await _syncPostulationOperation(op);
      case 'document':
        return await _syncDocumentOperation(op);
      case 'followUp':
        return await _syncFollowUpOperation(op);
      default:
        print('Tipo de entidad desconocido: ${op.entityType}');
        return true; // Considerar procesado para evitar bloquear la cola
    }
  }

  // ─── USER ──────────────────────────────────────────────────────────
  Future<bool> _syncUserOperation(PendingOperationEntry op) async {
    if (op.operationType == 'update') {
      final userMap = jsonDecode(op.payload) as Map<String, dynamic>;
      final user = UserModel.fromMap(userMap);
      await _firestoreService.createOrUpdateUser(user);
      return true;
    } else if (op.operationType == 'updateStatus') {
      final statusStr = op.payload;
      final status = UserStatus.values.firstWhere((e) => e.toString().split('.').last == statusStr);
      await _firestoreService.updateUserStatus(op.entityId, status);
      return true;
    }
    return true;
  }

  // ─── COMPANY ───────────────────────────────────────────────────────
  Future<bool> _syncCompanyOperation(PendingOperationEntry op) async {
    if (op.operationType == 'createOrUpdate') {
      final companyMap = jsonDecode(op.payload) as Map<String, dynamic>;
      final company = EmpresaModel.fromMap(companyMap);
      await _firestoreService.createOrUpdateEmpresa(company);
      return true;
    }
    return true;
  }

  // ─── OFFER ─────────────────────────────────────────────────────────
  Future<bool> _syncOfferOperation(PendingOperationEntry op) async {
    if (op.operationType == 'createOrUpdate') {
      final offerMap = jsonDecode(op.payload) as Map<String, dynamic>;
      final offer = OfertaModel.fromMap(offerMap);
      await _firestoreService.createOrUpdateOferta(offer);
      return true;
    } else if (op.operationType == 'delete') {
      await _firestoreService.deleteOferta(op.entityId);
      return true;
    }
    return true;
  }

  // ─── POSTULATION ───────────────────────────────────────────────────
  Future<bool> _syncPostulationOperation(PendingOperationEntry op) async {
    if (op.operationType == 'createOrUpdate') {
      final postMap = jsonDecode(op.payload) as Map<String, dynamic>;
      final post = PostulacionModel.fromMap(postMap);
      await _firestoreService.createOrUpdatePostulacion(post);
      await _db.postulationDao.markSynced(op.entityId);
      return true;
    } else if (op.operationType == 'updateStatus') {
      final map = jsonDecode(op.payload) as Map<String, dynamic>;
      final estadoStr = map['estado'] as String;
      final motivo = map['motivoRechazo'] as String?;
      final estado = PostulacionEstado.values.firstWhere(
        (e) => e.toString().split('.').last == estadoStr,
      );
      await _firestoreService.updateApplicationStatus(
        op.entityId,
        estado,
        motivo: motivo,
      );
      await _db.postulationDao.markSynced(op.entityId);
      return true;
    }
    return true;
  }

  // ─── DOCUMENT ──────────────────────────────────────────────────────
  Future<bool> _syncDocumentOperation(PendingOperationEntry op) async {
    if (op.operationType == 'create' || op.operationType == 'update') {
      final docMap = jsonDecode(op.payload) as Map<String, dynamic>;
      final doc = DocumentModel.fromMap(docMap);
      // set es seguro tanto para crear como para actualizar
      await _firestore.collection('documentos').doc(doc.id).set(doc.toMap());
      return true;
    } else if (op.operationType == 'delete') {
      await _documentService.eliminarDocumento(op.entityId);
      return true;
    }
    return true;
  }

  // ─── FOLLOW UP ─────────────────────────────────────────────────────
  Future<bool> _syncFollowUpOperation(PendingOperationEntry op) async {
    if (op.operationType == 'create' || op.operationType == 'update') {
      final followUpMap = jsonDecode(op.payload) as Map<String, dynamic>;
      final followUp = SeguimientoModel.fromMap(followUpMap);
      await _firestore.collection('seguimientos').doc(followUp.id).set(followUp.toMap());
      return true;
    } else if (op.operationType == 'updateStatus') {
      final map = jsonDecode(op.payload) as Map<String, dynamic>;
      final id = map['id'] as String;
      final estadoVal = map['estado'] as String;
      final estado = EstadoSeguimiento.fromValue(estadoVal);
      await _seguimientoService.actualizarEstado(id, estado);
      return true;
    } else if (op.operationType == 'delete') {
      await _seguimientoService.eliminarSeguimiento(op.entityId);
      return true;
    }
    return true;
  }
}
