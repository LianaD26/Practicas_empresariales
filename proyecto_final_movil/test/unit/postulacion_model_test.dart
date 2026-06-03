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

  test('Postulación con syncStatus pendingSync requiere sincronización', () {
    final postulacion = PostulacionModel(
      id: '1',
      ofertaId: 'of1',
      studentId: 'st1',
      createdAt: DateTime.now(),
      syncStatus: 'pendingSync',
    );

    expect(postulacion.necesitaSincronizacion, true);
    expect(postulacion.etiquetaSincronizacion, 'Pendiente de sincronización');
  });

  test('fromMap acepta fechas ISO del payload local de sincronización', () {
    final postulacion = PostulacionModel.fromMap({
      'id': '1',
      'ofertaId': 'of1',
      'studentId': 'st1',
      'estado': 'postulado',
      'createdAt': '2026-06-03T15:03:03.504',
      'syncStatus': 'pendingSync',
    });

    expect(postulacion.createdAt, DateTime.parse('2026-06-03T15:03:03.504'));
    expect(postulacion.estado, PostulacionEstado.postulado);
  });
}