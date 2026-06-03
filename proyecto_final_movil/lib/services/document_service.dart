import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/document_model.dart';

class DocumentService {
  static final DocumentService _instance = DocumentService._internal();

  factory DocumentService() {
    return _instance;
  }

  DocumentService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'documentos';

  /// Crea un nuevo documento en Firestore
  Future<DocumentModel> crearDocumento({
    required String nombre,
    required TipoDocumento tipo,
    required String url,
    required String usuarioId,
  }) async {
    try {
      final docRef = _firestore.collection(_collection).doc();

      final documento = DocumentModel(
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
  Future<DocumentModel?> getDocumentoPorId(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        return DocumentModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error obteniendo documento: $e');
      return null;
    }
  }

  /// Obtiene todos los documentos de un usuario
  Future<List<DocumentModel>> getDocumentosPorUsuario(String usuarioId) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('usuarioId', isEqualTo: usuarioId)
          .get();

      final lista = query.docs
          .map((doc) => DocumentModel.fromMap(doc.data()))
          .toList();
      lista.sort((a, b) => b.fechaSubida.compareTo(a.fechaSubida));
      return lista;
    } catch (e) {
      print('Error obteniendo documentos del usuario: $e');
      return [];
    }
  }

  /// Stream que escucha los documentos de un usuario en tiempo real
  Stream<List<DocumentModel>> getDocumentosPorUsuarioStream(String usuarioId) {
    return _firestore
        .collection(_collection)
        .where('usuarioId', isEqualTo: usuarioId)
        .snapshots()
        .map((snapshot) {
          final lista = snapshot.docs
              .map((doc) => DocumentModel.fromMap(doc.data()))
              .toList();
          lista.sort((a, b) => b.fechaSubida.compareTo(a.fechaSubida));
          return lista;
        });
  }

  /// Obtiene documentos de un usuario filtrados por tipo (ordenado en cliente)
  Future<List<DocumentModel>> getDocumentosPorTipo(
    String usuarioId,
    TipoDocumento tipo,
  ) async {
    try {
      final query = await _firestore
          .collection(_collection)
          .where('usuarioId', isEqualTo: usuarioId)
          .get();

      final lista = query.docs
          .map((doc) => DocumentModel.fromMap(doc.data()))
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
  Future<void> actualizarDocumento(DocumentModel documento) async {
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
