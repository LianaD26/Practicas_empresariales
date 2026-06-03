import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_final_movil/models/postulation_model.dart';

void main() {

  test('Nueva postulación inicia en estado postulado', () {
    final postulacion = PostulacionModel(
      id: '1',
      ofertaId: 'of1',
      studentId: 'st1',
      createdAt: DateTime.now(),
    );

    expect(
      postulacion.estado,
      PostulacionEstado.postulado,
    );
  });

  test('Postulación con syncStatus pending requiere sincronización', () {
    final postulacion = PostulacionModel(
      id: '1',
      ofertaId: 'of1',
      studentId: 'st1',
      createdAt: DateTime.now(),
      syncStatus: 'pending',
    );

    expect(
      postulacion.necesitaSincronizacion,
      true,
    );
  });
}