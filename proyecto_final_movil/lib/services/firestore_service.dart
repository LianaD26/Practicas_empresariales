import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/company_model.dart';
import '../models/oferta_model.dart';
import '../models/postulacion_model.dart';
import '../core/constants.dart';
import 'permission_service.dart';

/// Servicio centralizado para todas las operaciones con Firestore
class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ============= USERS =============

  /// Obtiene un usuario por ID
  Future<UserModel?> getUserById(String uid) async {
    try {
      final doc = await _firestore
          .collection(FirestoreCollections.users)
          .doc(uid)
          .get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo usuario: $e');
      return null;
    }
  }

  /// Stream de un usuario
  Stream<UserModel?> getUserStream(String uid) {
    return _firestore
        .collection(FirestoreCollections.users)
        .doc(uid)
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists) {
            return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
          }
          return null;
        });
  }

  /// Crea o actualiza un usuario
  Future<void> createOrUpdateUser(UserModel user) async {
    try {
      await _firestore
          .collection(FirestoreCollections.users)
          .doc(user.uid)
          .set(user.toMap(), SetOptions(merge: true));
    } catch (e) {
      print('Error creando/actualizando usuario: $e');
      rethrow;
    }
  }

  /// Actualiza el estado de un usuario
  Future<void> updateUserStatus(String uid, UserStatus status) async {
    try {
      await _firestore.collection(FirestoreCollections.users).doc(uid).update({
        'status': status.toString().split('.').last,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error actualizando estado del usuario: $e');
      rethrow;
    }
  }

  /// Lista todos los usuarios
  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.users)
          .get();
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    } catch (e) {
      print('Error listando usuarios: $e');
      return [];
    }
  }

  /// Lista usuarios por rol
  Future<List<UserModel>> getUsersByRole(String role) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.users)
          .where('role', isEqualTo: role)
          .get();
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    } catch (e) {
      print('Error listando usuarios por rol: $e');
      return [];
    }
  }

  // ============= EMPRESAS =============

  /// Obtiene una empresa por ID
  Future<EmpresaModel?> getEmpresaById(String id) async {
    try {
      final doc = await _firestore
          .collection(FirestoreCollections.companies)
          .doc(id)
          .get();
      if (doc.exists) {
        return EmpresaModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo empresa: $e');
      return null;
    }
  }

  /// Stream de una empresa
  Stream<EmpresaModel?> getEmpresaStream(String id) {
    return _firestore
        .collection(FirestoreCollections.companies)
        .doc(id)
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists) {
            return EmpresaModel.fromMap(
              snapshot.data() as Map<String, dynamic>,
            );
          }
          return null;
        });
  }

  /// Crea o actualiza una empresa
  Future<String> createOrUpdateEmpresa(EmpresaModel empresa) async {
    try {
      final docRef = _firestore
          .collection(FirestoreCollections.companies)
          .doc(empresa.id);
      await docRef.set(empresa.toMap(), SetOptions(merge: true));
      return empresa.id;
    } catch (e) {
      print('Error creando/actualizando empresa: $e');
      rethrow;
    }
  }

  /// Lista todas las empresas activas
  Future<List<EmpresaModel>> getAllEmpresas() async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.companies)
          .where('isActive', isEqualTo: true)
          .get();
      return snapshot.docs
          .map((doc) => EmpresaModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error listando empresas: $e');
      return [];
    }
  }

  // ============= OFERTAS =============

  /// Obtiene una oferta por ID
  Future<OfertaModel?> getOfertaById(String id) async {
    try {
      final doc = await _firestore
          .collection(FirestoreCollections.offers)
          .doc(id)
          .get();
      if (doc.exists) {
        return OfertaModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo oferta: $e');
      return null;
    }
  }

  /// Stream de una oferta
  Stream<OfertaModel?> getOfertaStream(String id) {
    return _firestore
        .collection(FirestoreCollections.offers)
        .doc(id)
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists) {
            return OfertaModel.fromMap(snapshot.data() as Map<String, dynamic>);
          }
          return null;
        });
  }

  /// Crea o actualiza una oferta
  Future<String> createOrUpdateOferta(OfertaModel oferta) async {
    try {
      final docRef = _firestore
          .collection(FirestoreCollections.offers)
          .doc(oferta.id);
      await docRef.set(oferta.toMap(), SetOptions(merge: true));
      return oferta.id;
    } catch (e) {
      print('Error creando/actualizando oferta: $e');
      rethrow;
    }
  }

  /// Lista ofertas publicadas
  Future<List<OfertaModel>> getPublishedOffers() async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.offers)
          .where('estado', isEqualTo: 'publicada')
          .get();
      final list = snapshot.docs
          .map((doc) => OfertaModel.fromMap(doc.data()))
          .toList();
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    } catch (e) {
      print('Error listando ofertas publicadas: $e');
      return [];
    }
  }

  /// Stream de ofertas publicadas (para actualización en tiempo real)
  Stream<List<OfertaModel>> getPublishedOffersStream() {
    return _firestore
        .collection(FirestoreCollections.offers)
        .where('estado', isEqualTo: 'publicada')
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => OfertaModel.fromMap(doc.data()))
              .toList();
          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return list;
        });
  }

  /// Stream de ofertas de una empresa (tiempo real)
  Stream<List<OfertaModel>> getOfertasByCompanyStream(String companyId) {
    return _firestore
        .collection(FirestoreCollections.offers)
        .where('empresaId', isEqualTo: companyId)
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => OfertaModel.fromMap(doc.data()))
              .toList();
          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return list;
        });
  }

  /// Elimina una oferta por ID
  Future<void> deleteOferta(String ofertaId) async {
    try {
      await _firestore
          .collection(FirestoreCollections.offers)
          .doc(ofertaId)
          .delete();
    } catch (e) {
      print('Error eliminando oferta: $e');
      rethrow;
    }
  }

  /// Lista ofertas de una empresa
  Future<List<OfertaModel>> getOfertasByCompany(String companyId) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.offers)
          .where('empresaId', isEqualTo: companyId)
          .get();
      final list = snapshot.docs
          .map((doc) => OfertaModel.fromMap(doc.data()))
          .toList();
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    } catch (e) {
      print('Error listando ofertas de empresa: $e');
      return [];
    }
  }

  // ============= POSTULACIONES =============

  /// Obtiene una postulación por ID
  Future<PostulacionModel?> getPostulacionById(String id) async {
    try {
      final doc = await _firestore
          .collection(FirestoreCollections.applications)
          .doc(id)
          .get();
      if (doc.exists) {
        return PostulacionModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo postulación: $e');
      return null;
    }
  }

  /// Crea o actualiza una postulación
  Future<String> createOrUpdatePostulacion(PostulacionModel postulacion) async {
    try {
      final docRef = _firestore
          .collection(FirestoreCollections.applications)
          .doc(postulacion.id);
      await docRef.set(postulacion.toMap(), SetOptions(merge: true));
      return postulacion.id;
    } catch (e) {
      print('Error creando/actualizando postulación: $e');
      rethrow;
    }
  }

  /// Verifica si un estudiante ya se postuló a una oferta
  Future<bool> hasStudentApplied(String studentId, String offerId) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.applications)
          .where('studentId', isEqualTo: studentId)
          .where('ofertaId', isEqualTo: offerId)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error verificando postulación duplicada: $e');
      return false;
    }
  }

  /// Obtiene postulaciones de un estudiante
  Future<List<PostulacionModel>> getApplicationsByStudent(
    String studentId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.applications)
          .where('studentId', isEqualTo: studentId)
          .get();
      final list = snapshot.docs
          .map((doc) => PostulacionModel.fromMap(doc.data()))
          .toList();
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    } catch (e) {
      print('Error listando postulaciones del estudiante: $e');
      return [];
    }
  }

  /// Stream de postulaciones de un estudiante
  Stream<List<PostulacionModel>> getApplicationsByStudentStream(
    String studentId,
  ) {
    return _firestore
        .collection(FirestoreCollections.applications)
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => PostulacionModel.fromMap(doc.data()))
              .toList();
          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return list;
        });
  }

  /// Obtiene postulaciones para una oferta
  Future<List<PostulacionModel>> getApplicationsByOffer(String offerId) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.applications)
          .where('ofertaId', isEqualTo: offerId)
          .get();
      final list = snapshot.docs
          .map((doc) => PostulacionModel.fromMap(doc.data()))
          .toList();
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    } catch (e) {
      print('Error listando postulaciones de oferta: $e');
      return [];
    }
  }

  /// Stream de postulaciones para una oferta
  Stream<List<PostulacionModel>> getApplicationsByOfferStream(String offerId) {
    return _firestore
        .collection(FirestoreCollections.applications)
        .where('ofertaId', isEqualTo: offerId)
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => PostulacionModel.fromMap(doc.data()))
              .toList();
          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return list;
        });
  }

  /// Actualiza el estado de una postulación.
  /// Solo la empresa puede cambiar el estado de las postulaciones a sus ofertas
  /// REGLA 6: Si [estado] es [PostulacionEstado.rechazado], [motivo] es obligatorio.
  Future<void> updateApplicationStatus(
    String applicationId,
    PostulacionEstado estado, {
    String? motivo,
    UserModel? currentUser,
  }) async {
    final permissionService = PermissionService();

    // Validar que la empresa tiene permiso para cambiar estado
    if (currentUser != null) {
      if (currentUser.role != UserRoles.company) {
        throw ArgumentError(
          'Solo las empresas pueden cambiar el estado de postulaciones',
        );
      }
      if (!currentUser.isActive) {
        throw ArgumentError('Tu cuenta debe estar activa para cambiar estados');
      }
    }

    // REGLA 6: Aplica validación de motivo para rechazo
    permissionService.validateRejectionReason(estado, motivo);

    try {
      await _firestore
          .collection(FirestoreCollections.applications)
          .doc(applicationId)
          .update({
            'estado': estado.toString().split('.').last,
            'motivoRechazo': motivo,
            'updatedAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      print('Error actualizando estado de postulación: $e');
      rethrow;
    }
  }

  /// Obtiene todas las postulaciones (para coordinador)
  Future<List<PostulacionModel>> getAllApplications() async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreCollections.applications)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => PostulacionModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error listando todas las postulaciones: $e');
      return [];
    }
  }

  /// Stream de todas las postulaciones (para coordinador)
  Stream<List<PostulacionModel>> getAllApplicationsStream() {
    return _firestore
        .collection(FirestoreCollections.applications)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PostulacionModel.fromMap(doc.data()))
              .toList(),
        );
  }

  // ============= BATCH OPERATIONS =============

  /// Eliminación lógica de un documento (soft delete)
  Future<void> softDeleteUser(String uid) async {
    try {
      await _firestore.collection(FirestoreCollections.users).doc(uid).update({
        'isActive': false,
        'status': 'blocked',
      });
    } catch (e) {
      print('Error eliminando usuario: $e');
      rethrow;
    }
  }
}

