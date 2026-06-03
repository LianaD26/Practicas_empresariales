import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import '../models/offer_model.dart';
import '../data/local/database.dart';
import '../services/firestore_service.dart';
import '../services/connectivity_service.dart';

class OfferRepository {
  final AppDatabase _db;
  final FirestoreService _firestoreService = FirestoreService();
  final ConnectivityService _connectivityService = ConnectivityService();

  OfferRepository(this._db);

  OfertaModel _toModel(OfferEntry entry) {
    return OfertaModel(
      id: entry.id,
      titulo: entry.titulo,
      descripcion: entry.descripcion,
      empresaId: entry.empresaId,
      estado: OfertaEstado.values.firstWhere(
        (e) => e.toString().split('.').last == entry.estado,
        orElse: () => OfertaEstado.borrador,
      ),
      fechaLimite: entry.fechaLimite,
      vacantes: entry.vacantes,
      ubicacion: entry.ubicacion,
      areaPractica: entry.areaPractica,
      requisitos: entry.requisitos,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }

  OfferEntriesCompanion _toCompanion(OfertaModel model) {
    return OfferEntriesCompanion(
      id: Value(model.id),
      titulo: Value(model.titulo),
      descripcion: Value(model.descripcion),
      empresaId: Value(model.empresaId),
      estado: Value(model.estado.toString().split('.').last),
      fechaLimite: Value(model.fechaLimite),
      vacantes: Value(model.vacantes),
      ubicacion: Value(model.ubicacion),
      areaPractica: Value(model.areaPractica),
      requisitos: Value(model.requisitos),
      createdAt: Value(model.createdAt),
      updatedAt: Value(model.updatedAt),
    );
  }

  /// Observa ofertas publicadas locales y actualiza desde Firestore en segundo plano si hay red.
  Stream<List<OfertaModel>> watchPublishedOffers() {
    _syncPublishedOffers();
    return _db.offerDao.watchPublished().map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Observa ofertas de una empresa local y actualiza en segundo plano.
  Stream<List<OfertaModel>> watchOffersByCompany(String companyId) {
    _syncOffersByCompany(companyId);
    return _db.offerDao.watchByCompany(companyId).map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Obtiene una oferta por ID. Intenta primero local, luego remoto.
  Future<OfertaModel?> getOfertaById(String id) async {
    final local = await _db.offerDao.getById(id);
    if (local != null) {
      _syncOffer(id);
      return _toModel(local);
    }

    if (await _connectivityService.hasConnection) {
      final remote = await _firestoreService.getOfertaById(id);
      if (remote != null) {
        await _db.offerDao.upsert(_toCompanion(remote));
        return remote;
      }
    }
    return null;
  }

  /// Crea o actualiza una oferta (offline-first).
  Future<void> createOrUpdateOferta(OfertaModel oferta) async {
    await _db.offerDao.upsert(_toCompanion(oferta));

    if (await _connectivityService.hasConnection) {
      try {
        await _firestoreService.createOrUpdateOferta(oferta);
        return;
      } catch (e) {
        print('Fallo guardado remoto de oferta, encolando: $e');
      }
    }

    await _db.pendingOperationsDao.enqueue(
      operationType: 'createOrUpdate',
      entityType: 'offer',
      entityId: oferta.id,
      payload: _serializeOffer(oferta),
    );
  }

  /// Elimina una oferta (offline-first).
  Future<void> deleteOferta(String ofertaId) async {
    // 1. Eliminar local
    await _db.offerDao.deleteById(ofertaId);

    // 2. Sincronizar o encolar
    if (await _connectivityService.hasConnection) {
      await _firestoreService.deleteOferta(ofertaId);
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'delete',
        entityType: 'offer',
        entityId: ofertaId,
        payload: '',
      );
    }
  }

  // ================= SINCRONIZACIÓN EN SEGUNDO PLANO =================

  Future<void> _syncPublishedOffers() async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _firestoreService.getPublishedOffers();
        final companions = remote.map(_toCompanion).toList();
        await _db.offerDao.upsertAll(companions);
      }
    } catch (e) {
      print('Error syncing published offers: $e');
    }
  }

  Future<void> _syncOffersByCompany(String companyId) async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _firestoreService.getOfertasByCompany(companyId);
        final companions = remote.map(_toCompanion).toList();
        await _db.offerDao.upsertAll(companions);
      }
    } catch (e) {
      print('Error syncing offers for company $companyId: $e');
    }
  }

  Future<void> _syncOffer(String id) async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _firestoreService.getOfertaById(id);
        if (remote != null) {
          await _db.offerDao.upsert(_toCompanion(remote));
        }
      }
    } catch (e) {
      print('Error syncing offer $id: $e');
    }
  }

  String _serializeOffer(OfertaModel oferta) {
    final map = {
      'id': oferta.id,
      'titulo': oferta.titulo,
      'descripcion': oferta.descripcion,
      'empresaId': oferta.empresaId,
      'estado': oferta.estado.toString().split('.').last,
      'fechaLimite': oferta.fechaLimite.toIso8601String(),
      'vacantes': oferta.vacantes,
      'ubicacion': oferta.ubicacion,
      'areaPractica': oferta.areaPractica,
      'requisitos': oferta.requisitos,
      'createdAt': oferta.createdAt.toIso8601String(),
      'updatedAt': oferta.updatedAt?.toIso8601String(),
    };
    return jsonEncode(map);
  }
}
