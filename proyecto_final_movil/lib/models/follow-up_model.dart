import '../core/map_parsers.dart';

/// Estados válidos de un seguimiento
enum EstadoSeguimiento {
  pendiente('pendiente', 'Pendiente'),
  enProceso('en_proceso', 'En Proceso'),
  aprobado('aprobado', 'Aprobado'),
  rechazado('rechazado', 'Rechazado');

  final String value;
  final String label;

  const EstadoSeguimiento(this.value, this.label);

  /// Convierte un String de Firestore al enum
  static EstadoSeguimiento fromValue(String value) {
    return EstadoSeguimiento.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EstadoSeguimiento.pendiente,
    );
  }
}

class SeguimientoModel {
  final String id;
  final DateTime fecha;
  final String comentario;
  final EstadoSeguimiento estado;
  final String postulacionId;

  SeguimientoModel({
    required this.id,
    required this.fecha,
    required this.comentario,
    required this.estado,
    required this.postulacionId,
  });

  /// Convierte el modelo a JSON para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'comentario': comentario,
      'estado': estado.value,
      'postulacionId': postulacionId,
    };
  }

  /// Crea un modelo desde un mapa de Firestore
  factory SeguimientoModel.fromMap(Map<String, dynamic> map) {
    return SeguimientoModel(
      id: map['id'] ?? '',
      fecha: parseMapDateTime(map['fecha']),
      comentario: map['comentario'] ?? '',
      estado: EstadoSeguimiento.fromValue(map['estado'] ?? 'pendiente'),
      postulacionId: map['postulacionId'] ?? '',
    );
  }

  /// Copia el modelo con cambios
  SeguimientoModel copyWith({
    String? id,
    DateTime? fecha,
    String? comentario,
    EstadoSeguimiento? estado,
    String? postulacionId,
  }) {
    return SeguimientoModel(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      comentario: comentario ?? this.comentario,
      estado: estado ?? this.estado,
      postulacionId: postulacionId ?? this.postulacionId,
    );
  }
}
