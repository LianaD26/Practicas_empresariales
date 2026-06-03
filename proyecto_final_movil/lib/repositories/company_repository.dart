import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import '../models/company_model.dart';
import '../data/local/database.dart';
import '../services/firestore_service.dart';
import '../services/connectivity_service.dart';

class CompanyRepository {
  final AppDatabase _db;
  final FirestoreService _firestoreService = FirestoreService();
  final ConnectivityService _connectivityService = ConnectivityService();

  CompanyRepository(this._db);

  EmpresaModel _toModel(CompanyEntry entry) {
    return EmpresaModel(
      id: entry.id,
      nombre: entry.nombre,
      descripcion: entry.descripcion,
      ubicacion: entry.ubicacion,
      contacto: entry.contacto,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      isActive: entry.isActive,
    );
  }

  CompanyEntriesCompanion _toCompanion(EmpresaModel model) {
    return CompanyEntriesCompanion(
      id: Value(model.id),
      nombre: Value(model.nombre),
      descripcion: Value(model.descripcion),
      ubicacion: Value(model.ubicacion),
      contacto: Value(model.contacto),
      createdAt: Value(model.createdAt),
      updatedAt: Value(model.updatedAt),
      isActive: Value(model.isActive),
    );
  }

  /// Observa todas las empresas activas locales y las actualiza desde Firestore en segundo plano si hay red.
  Stream<List<EmpresaModel>> watchActiveCompanies() {
    _syncActiveCompanies();
    return _db.companyDao.watchActive().map(
          (entries) => entries.map(_toModel).toList(),
        );
  }

  /// Observa una empresa por ID.
  Stream<EmpresaModel?> watchCompanyById(String id) {
    _syncCompany(id);
    return _db.companyDao.watchById(id).map((entry) {
      if (entry == null) return null;
      return _toModel(entry);
    });
  }

  /// Obtiene una empresa por ID.
  Future<EmpresaModel?> getCompanyById(String id) async {
    final local = await _db.companyDao.getById(id);
    if (local != null) {
      _syncCompany(id);
      return _toModel(local);
    }

    if (await _connectivityService.hasConnection) {
      final remote = await _firestoreService.getEmpresaById(id);
      if (remote != null) {
        await _db.companyDao.upsert(_toCompanion(remote));
        return remote;
      }
    }
    return null;
  }

  /// Crea o actualiza una empresa (offline-first).
  Future<String> createOrUpdateEmpresa(EmpresaModel empresa) async {
    // 1. Guardar local
    await _db.companyDao.upsert(_toCompanion(empresa));

    // 2. Sincronizar o encolar
    if (await _connectivityService.hasConnection) {
      await _firestoreService.createOrUpdateEmpresa(empresa);
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'createOrUpdate',
        entityType: 'company',
        entityId: empresa.id,
        payload: _serializeCompany(empresa),
      );
    }
    return empresa.id;
  }

  // ================= SINCRONIZACIÓN EN SEGUNDO PLANO =================

  Future<void> _syncActiveCompanies() async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _firestoreService.getAllEmpresas();
        final companions = remote.map(_toCompanion).toList();
        await _db.companyDao.upsertAll(companions);
      }
    } catch (e) {
      print('Error syncing active companies: $e');
    }
  }

  Future<void> _syncCompany(String id) async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _firestoreService.getEmpresaById(id);
        if (remote != null) {
          await _db.companyDao.upsert(_toCompanion(remote));
        }
      }
    } catch (e) {
      print('Error syncing company $id: $e');
    }
  }

  String _serializeCompany(EmpresaModel empresa) {
    final map = {
      'id': empresa.id,
      'nombre': empresa.nombre,
      'descripcion': empresa.descripcion,
      'ubicacion': empresa.ubicacion,
      'contacto': empresa.contacto,
      'createdAt': empresa.createdAt.toIso8601String(),
      'updatedAt': empresa.updatedAt?.toIso8601String(),
      'isActive': empresa.isActive,
    };
    return jsonEncode(map);
  }
}
