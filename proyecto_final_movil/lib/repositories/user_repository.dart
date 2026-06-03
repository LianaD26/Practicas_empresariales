import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart';
import '../models/user_model.dart';
import '../data/local/database.dart';
import '../services/firestore_service.dart';
import '../services/connectivity_service.dart';

class UserRepository {
  final AppDatabase _db;
  final FirestoreService _firestoreService = FirestoreService();
  final ConnectivityService _connectivityService = ConnectivityService();

  UserRepository(this._db);

  UserModel _toModel(UserEntry entry) {
    return UserModel(
      uid: entry.uid,
      email: entry.email,
      displayName: entry.displayName,
      role: entry.role,
      status: UserStatus.values.firstWhere(
        (e) => e.toString().split('.').last == entry.status,
        orElse: () => UserStatus.pendingApproval,
      ),
      createdAt: entry.createdAt,
    );
  }

  UserEntriesCompanion _toCompanion(UserModel model) {
    return UserEntriesCompanion(
      uid: Value(model.uid),
      email: Value(model.email),
      displayName: Value(model.displayName),
      role: Value(model.role),
      status: Value(model.status.toString().split('.').last),
      createdAt: Value(model.createdAt),
    );
  }

  /// Obtiene un flujo en tiempo real (Stream) del usuario por UID.
  /// Lee localmente e inicia sincronización remota si hay conexión.
  Stream<UserModel?> getUserStream(String uid) {
    // Sincronizar en segundo plano sin bloquear
    _syncUser(uid);
    
    return _db.userDao.watchById(uid).map((entry) {
      if (entry == null) return null;
      return _toModel(entry);
    });
  }

  /// Obtiene un usuario por ID. Primero intenta localmente.
  Future<UserModel?> getUserById(String uid) async {
    final local = await _db.userDao.getById(uid);
    if (local != null) {
      // Intentar actualizar local en background
      _syncUser(uid);
      return _toModel(local);
    }
    
    // Si no está local, buscar remoto y guardar
    if (await _connectivityService.hasConnection) {
      final remote = await _firestoreService.getUserById(uid);
      if (remote != null) {
        await _db.userDao.upsert(_toCompanion(remote));
        return remote;
      }
    }
    return null;
  }

  /// Crea o actualiza un usuario (offline-first).
  Future<void> createOrUpdateUser(UserModel user) async {
    // 1. Guardar localmente siempre
    await _db.userDao.upsert(_toCompanion(user));

    // 2. Intentar guardar remoto o registrar en la cola offline
    if (await _connectivityService.hasConnection) {
      await _firestoreService.createOrUpdateUser(user);
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'update',
        entityType: 'user',
        entityId: user.uid,
        payload: _serializeUserModel(user),
      );
    }
  }

  /// Actualiza el estado de un usuario (offline-first).
  Future<void> updateUserStatus(String uid, UserStatus status) async {
    final localUser = await _db.userDao.getById(uid);
    if (localUser != null) {
      final updated = _toModel(localUser).copyWith(status: status);
      await _db.userDao.upsert(_toCompanion(updated));
    }

    if (await _connectivityService.hasConnection) {
      await _firestoreService.updateUserStatus(uid, status);
    } else {
      await _db.pendingOperationsDao.enqueue(
        operationType: 'updateStatus',
        entityType: 'user',
        entityId: uid,
        payload: status.toString().split('.').last,
      );
    }
  }

  /// Obtiene todos los usuarios.
  Stream<List<UserModel>> getAllUsersStream() {
    _syncAllUsers();
    return _db.userDao.watchAll().map(
      (entries) => entries.map(_toModel).toList(),
    );
  }

  /// Obtiene usuarios por rol.
  Stream<List<UserModel>> watchUsersByRole(String role) {
    _syncAllUsers(); // Sincroniza todos los usuarios
    return _db.userDao.watchByRole(role).map(
      (entries) => entries.map(_toModel).toList(),
    );
  }

  /// Sincronización en segundo plano de un usuario
  Future<void> _syncUser(String uid) async {
    try {
      if (await _connectivityService.hasConnection) {
        final remote = await _firestoreService.getUserById(uid);
        if (remote != null) {
          await _db.userDao.upsert(_toCompanion(remote));
        }
      }
    } catch (e) {
      print('Error al sincronizar usuario $uid: $e');
    }
  }

  /// Sincronización en segundo plano de todos los usuarios
  Future<void> _syncAllUsers() async {
    try {
      if (await _connectivityService.hasConnection) {
        final remoteUsers = await _firestoreService.getAllUsers();
        final companions = remoteUsers.map(_toCompanion).toList();
        await _db.userDao.upsertAll(companions);
      }
    } catch (e) {
      print('Error al sincronizar todos los usuarios: $e');
    }
  }

  String _serializeUserModel(UserModel user) {
    final map = {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'role': user.role,
      'status': user.status.toString().split('.').last,
      'createdAt': user.createdAt.toIso8601String(),
    };
    return jsonEncode(map);
  }
}
