import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/documento_model.dart';

class DocumentoService {
  static final DocumentoService _instance = DocumentoService._internal();

  factory DocumentoService() {
    return _instance;
  }

  DocumentoService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'documentos';

  /// Crea un nuevo documento en Firestore
  Future<DocumentoModel> crearDocumento({
    required String nombre,
    required TipoDocumento tipo,
    required String url,
    required String usuarioId,
  }) async {
    try {
      final docRef = _firestore.collection(_collection).doc();

      final documento = DocumentoModel(
        id: docRef.id,
        nombre: nombre,
        tipo: tipo,
        url: url,
        fechaSubida: DateTime.now(),
        usuarioId: usuarioId,
      );

      await docRef.set(documento.toMap());
      return documento;
    } catch (e) {
      print('Error creando documento: $e');
      rethrow;
    }
  }

  /// Obtiene un documento por ID
  Future<DocumentoModel?> getDocumentoPorId(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        return DocumentoModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo documento: $e');
      return null;
    }
  }

  /// Obtiene todos los documentos de un usuario
  Future<List<DocumentoModel>> getDocumentosPorUsuario(String usuarioId) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('usuarioId', isEqualTo: usuarioId)
          .get();

      final lista = query.docs
          .map((doc) => DocumentoModel.fromMap(doc.data()))
          .toList();
      lista.sort((a, b) => b.fechaSubida.compareTo(a.fechaSubida));
      return lista;
    } catch (e) {
      print('Error obteniendo documentos del usuario: $e');
      return [];
    }
  }

  /// Stream que escucha los documentos de un usuario en tiempo real
  Stream<List<DocumentoModel>> getDocumentosPorUsuarioStream(String usuarioId) {
    return _firestore
        .collection(_collection)
        .where('usuarioId', isEqualTo: usuarioId)
        .snapshots()
        .map((snapshot) {
          final lista = snapshot.docs
              .map((doc) => DocumentoModel.fromMap(doc.data()))
              .toList();
          lista.sort((a, b) => b.fechaSubida.compareTo(a.fechaSubida));
          return lista;
        });
  }

  /// Obtiene documentos de un usuario filtrados por tipo (ordenado en cliente)
  Future<List<DocumentoModel>> getDocumentosPorTipo(
    String usuarioId,
    TipoDocumento tipo,
  ) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('usuarioId', isEqualTo: usuarioId)
          .get();

      final lista = query.docs
          .map((doc) => DocumentoModel.fromMap(doc.data()))
          .where((doc) => doc.tipo == tipo)
          .toList();
      lista.sort((a, b) => b.fechaSubida.compareTo(a.fechaSubida));
      return lista;
    } catch (e) {
      print('Error obteniendo documentos por tipo: $e');
      return [];
    }
  }

  /// Actualiza los datos de un documento
  Future<void> actualizarDocumento(DocumentoModel documento) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(documento.id)
          .update(documento.toMap());
    } catch (e) {
      print('Error actualizando documento: $e');
      rethrow;
    }
  }

  /// Elimina un documento por ID
  Future<void> eliminarDocumento(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print('Error eliminando documento: $e');
      rethrow;
    }
  }
}
