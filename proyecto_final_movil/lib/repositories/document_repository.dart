import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import '../models/document_model.dart';
import '../data/local/database.dart';
import '../services/document_service.dart';
import '../services/connectivity_service.dart';

class DocumentRepository {
  final AppDatabase _db;
  final DocumentService _documentService = DocumentService();
  final ConnectivityService _connectivityService = ConnectivityService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DocumentRepository(this._db);

  DocumentModel _toModel(DocumentEntry entry) {
    return DocumentModel(
      id: entry.id,
      nombre: entry.nombre,
      tipo: TipoDocumento.fromValue(entry.tipo),
      url: entry.url,
      fechaSubida: entry.fechaSubida,
      usuarioId: entry.usuarioId,
    );
  }

  DocumentEntriesCompanion _toCompanion(DocumentModel model) {
    return DocumentEntriesCompanion(
      id: Value(model.id),
      nombre: Value(model.nombre),
      tipo: Value(model.tipo.value),
      url: Value(model.url),
      fechaSubida: Value(model.fechaSubida),
      usuarioId: Value(model.usuarioId),
    );
  }

  /// Crea un nuevo documento (offline-first).
  Future<DocumentModel> crearDocumento({
    required String nombre,
    required TipoDocumento tipo,
    required String url,
    required String usuarioId,
  }) async {
    // Generar un ID único usando Firestore offline
    final docId = _firestore.collection('documentos').doc().id;

    final documento = DocumentModel(
      id: docId,
      nombre: nombre,
      tipo: tipo,
      url: url,
      fechaSubida: DateTime.now(),
      usuarioId: usuarioId,
    );

    // 1. Guardar local
    await _db.documentDao.upsert(_toCompanion(documento));

    // 2. Sincronizar o encolar
    if (await _connectivityService.hasConnection) {
      await _db.transaction(() async {
        // Ejecutamos remota directamente
        // Para respetar la firma de DocumentService, la invocamos pero usando nuestro ID generado
        // O alternativamente, podemos usar _firestore directamente para setear con nuestro ID.
        // Pero usemos firestore collection set para conservar el ID generado.
        await _firestore.collection('documentos').doc(documento.id).set(documento.toMap());
      });
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'create',
        entityType: 'document',
        entityId: documento.id,
        payload: _serializeDocument(documento),
      );
    }

    return documento;
  }

  /// Observa documentos de un usuario.
  Stream<List<DocumentModel>> watchDocumentosPorUsuario(String usuarioId) {
    _syncDocumentosPorUsuario(usuarioId);
    return _db.documentDao.watchByUser(usuarioId).map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Observa documentos de un usuario filtrados por tipo.
  Stream<List<DocumentModel>> watchDocumentosPorTipo(String usuarioId, TipoDocumento tipo) {
    _syncDocumentosPorUsuario(usuarioId);
    return _db.documentDao.watchByUserAndType(usuarioId, tipo.value).map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Actualiza un documento (offline-first).
  Future<void> actualizarDocumento(DocumentModel documento) async {
    // 1. Guardar local
    await _db.documentDao.upsert(_toCompanion(documento));

    // 2. Sincronizar o encolar
    if (await _connectivityService.hasConnection) {
      await _documentService.actualizarDocumento(documento);
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'update',
        entityType: 'document',
        entityId: documento.id,
        payload: _serializeDocument(documento),
      );
    }
  }

  /// Elimina un documento (offline-first).
  Future<void> eliminarDocumento(String id) async {
    // 1. Eliminar local
    await _db.documentDao.deleteById(id);

    // 2. Sincronizar o encolar
    if (await _connectivityService.hasConnection) {
      await _documentService.eliminarDocumento(id);
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'delete',
        entityType: 'document',
        entityId: id,
        payload: '',
      );
    }
  }

  // ================= SINCRONIZACIÓN EN SEGUNDO PLANO =================

  Future<void> _syncDocumentosPorUsuario(String usuarioId) async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _documentService.getDocumentosPorUsuario(usuarioId);
        final companions = remote.map(_toCompanion).toList();
        await _db.documentDao.upsertAll(companions);
      }
    } catch (e) {
      print('Error syncing documents for user $usuarioId: $e');
    }
  }

  String _serializeDocument(DocumentModel doc) {
    final map = {
      'id': doc.id,
      'nombre': doc.nombre,
      'tipo': doc.tipo.value,
      'url': doc.url,
      'fechaSubida': doc.fechaSubida.toIso8601String(),
      'usuarioId': doc.usuarioId,
    };
    return jsonEncode(map);
  }
}
