import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/seguimiento_model.dart';

class SeguimientoService {
  static final SeguimientoService _instance = SeguimientoService._internal();

  factory SeguimientoService() {
    return _instance;
  }

  SeguimientoService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'seguimientos';

  /// Crea un nuevo seguimiento en Firestore
  Future<SeguimientoModel> crearSeguimiento({
    required String comentario,
    required EstadoSeguimiento estado,
    required String postulacionId,
  }) async {
    try {
      final docRef = _firestore.collection(_collection).doc();

      final seguimiento = SeguimientoModel(
        id: docRef.id,
        fecha: DateTime.now(),
        comentario: comentario,
        estado: estado,
        postulacionId: postulacionId,
      );

      await docRef.set(seguimiento.toMap());
      return seguimiento;
    } catch (e) {
      print('Error creando seguimiento: $e');
      rethrow;
    }
  }

  /// Obtiene un seguimiento por ID
  Future<SeguimientoModel?> getSeguimientoPorId(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        return SeguimientoModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo seguimiento: $e');
      return null;
    }
  }

  /// Obtiene todos los seguimientos de una postulación
  Future<List<SeguimientoModel>> getSeguimientosPorPostulacion(
      String postulacionId) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('postulacionId', isEqualTo: postulacionId)
          .get();

      final lista = query.docs
          .map((doc) => SeguimientoModel.fromMap(doc.data()))
          .toList();
      lista.sort((a, b) => b.fecha.compareTo(a.fecha));
      return lista;
    } catch (e) {
      print('Error obteniendo seguimientos de la postulación: $e');
      return [];
    }
  }

  /// Stream que escucha los seguimientos de una postulación en tiempo real
  Stream<List<SeguimientoModel>> getSeguimientosPorPostulacionStream(
      String postulacionId) {
    return _firestore
        .collection(_collection)
        .where('postulacionId', isEqualTo: postulacionId)
        .snapshots()
        .map((snapshot) {
          final lista = snapshot.docs
              .map((doc) => SeguimientoModel.fromMap(doc.data()))
              .toList();
          lista.sort((a, b) => b.fecha.compareTo(a.fecha));
          return lista;
        });
  }

  /// Obtiene seguimientos filtrados por estado (ordenado en cliente)
  Future<List<SeguimientoModel>> getSeguimientosPorEstado(
      String postulacionId, EstadoSeguimiento estado) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('postulacionId', isEqualTo: postulacionId)
          .get();

      final lista = query.docs
          .map((doc) => SeguimientoModel.fromMap(doc.data()))
          .where((seg) => seg.estado == estado)
          .toList();
      lista.sort((a, b) => b.fecha.compareTo(a.fecha));
      return lista;
    } catch (e) {
      print('Error obteniendo seguimientos por estado: $e');
      return [];
    }
  }

  /// Actualiza los datos de un seguimiento
  Future<void> actualizarSeguimiento(SeguimientoModel seguimiento) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(seguimiento.id)
          .update(seguimiento.toMap());
    } catch (e) {
      print('Error actualizando seguimiento: $e');
      rethrow;
    }
  }

  /// Actualiza únicamente el estado de un seguimiento
  Future<void> actualizarEstado(String id, EstadoSeguimiento nuevoEstado) async {
    try {
      await _firestore.collection(_collection).doc(id).update({
        'estado': nuevoEstado.value,
      });
    } catch (e) {
      print('Error actualizando estado del seguimiento: $e');
      rethrow;
    }
  }

  /// Elimina un seguimiento por ID
  Future<void> eliminarSeguimiento(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print('Error eliminando seguimiento: $e');
      rethrow;
    }
  }
}
