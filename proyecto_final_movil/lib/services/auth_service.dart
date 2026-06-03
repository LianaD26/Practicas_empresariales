import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart'; // Incluye UserStatus enum
import '../repositories/user_repository.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Obtiene el usuario actual
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream que escucha cambios en el estado de autenticación
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Obtiene el modelo de usuario actual desde Firestore
  Future<UserModel?> getCurrentUserModel() async {
    try {
      if (currentUser == null) return null;

      final doc = await _firestore.collection('users').doc(currentUser!.uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo usuario actual: $e');
      return null;
    }
  }

  /// Obtiene un usuario por ID desde Firestore
  Future<UserModel?> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo usuario: $e');
      return null;
    }
  }

  /// Stream que escucha cambios en el documento del usuario actual
  Stream<UserModel?> getCurrentUserModelStream() {
    if (currentUser == null) {
      return Stream.value(null);
    }

    return _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  /// Registro con email y contraseña
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String displayName,
    String role = 'student',
    UserRepository? userRepository,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Actualizar display name
        await user.updateDisplayName(displayName);

        // Crear documento en Firestore
        final userModel = UserModel(
          uid: user.uid,
          email: email,
          displayName: displayName,
          role: role,
          status: UserStatus.pendingApproval,
          createdAt: DateTime.now(),
        );

        await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
        if (userRepository != null) {
          await userRepository.createOrUpdateUser(userModel);
        }

        return userModel;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print('Error en registro: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /// Inicio de sesión con email y contraseña
  Future<UserModel?> signIn({
    required String email,
    required String password,
    UserRepository? userRepository,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        UserModel? userModel;
        try {
          userModel = await getUserById(user.uid);
        } catch (e) {
          print('Firestore no disponible al iniciar sesión: $e');
        }

        if (userModel != null && userRepository != null) {
          await userRepository.createOrUpdateUser(userModel);
          return userModel;
        }

        if (userRepository != null) {
          final localUser = await userRepository.getUserById(user.uid);
          if (localUser != null) {
            return localUser;
          }
        }
        return null;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print('Error en login: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /// Cierre de sesión
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error al cerrar sesión: $e');
      rethrow;
    }
  }

  /// Enviar email de restablecimiento de contraseña
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error al enviar email: $e');
      rethrow;
    }
  }

  /// Verificar si el correo electrónico está verificado
  Future<bool> isEmailVerified() async {
    await currentUser?.reload();
    return currentUser?.emailVerified ?? false;
  }

  /// Enviar email de verificación
  Future<void> sendEmailVerification() async {
    try {
      if (currentUser != null && !currentUser!.emailVerified) {
        await currentUser!.sendEmailVerification();
      }
    } catch (e) {
      print('Error al enviar verificación: $e');
      rethrow;
    }
  }

  /// Actualizar perfil de usuario
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      if (currentUser != null) {
        await currentUser!.updateDisplayName(displayName);
        if (photoURL != null) {
          await currentUser!.updatePhotoURL(photoURL);
        }
      }
    } catch (e) {
      print('Error actualizando perfil: $e');
      rethrow;
    }
  }

  /// Actualizar rol del usuario en Firestore
  Future<void> updateUserRole(String uid, String newRole) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'role': newRole,
      });
    } catch (e) {
      print('Error actualizando rol: $e');
      rethrow;
    }
  }

  /// Actualizar estado de cuenta del usuario (pendingApproval, active, blocked)
  Future<void> updateUserStatus(String uid, UserStatus status) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'status': status.toString().split('.').last,
      });
    } catch (e) {
      print('Error actualizando estado: $e');
      rethrow;
    }
  }

  /// Eliminar cuenta de usuario
  Future<void> deleteAccount() async {
    try {
      if (currentUser != null) {
        // Eliminar documento de Firestore
        await _firestore.collection('users').doc(currentUser!.uid).delete();
        // Eliminar usuario de Firebase Auth
        await currentUser!.delete();
      }
    } catch (e) {
      print('Error eliminando cuenta: $e');
      rethrow;
    }
  }

  /// Validar token y renovar sesión
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      return await currentUser?.getIdToken(forceRefresh);
    } catch (e) {
      print('Error obteniendo token: $e');
      return null;
    }
  }

  /// Obtener todos los usuarios (solo para admin)
  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error obteniendo usuarios: $e');
      return [];
    }
  }
}
