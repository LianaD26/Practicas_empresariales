import '../core/constants.dart';
/// Estados posibles de una postulación
enum PostulacionEstado { postulado, preseleccionado, aprobado, rechazado }

/// Modelo de Postulación de Estudiante a Oferta
class PostulacionModel {
  final String id;
  final String ofertaId; // ID de la oferta
  final String studentId; // UID del estudiante
  final PostulacionEstado estado;
  final String? motivoRechazo; // Obligatorio si estado es rechazado
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? syncStatus; // offline-first: 'pendingSync', 'synced'

  PostulacionModel({
    required this.id,
    required this.ofertaId,
    required this.studentId,
    this.estado = PostulacionEstado.postulado,
    this.motivoRechazo,
    required this.createdAt,
    this.updatedAt,
    this.syncStatus = 'synced',
  });

  /// Convierte el modelo a JSON para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ofertaId': ofertaId,
      'studentId': studentId,
      'estado': estado.toString().split('.').last, // 'postulado', 'preseleccionado', 'aprobado', 'rechazado'
      'motivoRechazo': motivoRechazo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'syncStatus': syncStatus,
    };
  }

  /// Crea un modelo desde un mapa de Firestore
  factory PostulacionModel.fromMap(Map<String, dynamic> map) {
    // Convertir string de estado a enum
    PostulacionEstado estadoEnum = PostulacionEstado.postulado;
    if (map['estado'] != null) {
      try {
        estadoEnum = PostulacionEstado.values.firstWhere(
          (e) => e.toString().split('.').last == map['estado'],
          orElse: () => PostulacionEstado.postulado,
        );
      } catch (e) {
        estadoEnum = PostulacionEstado.postulado;
      }
    }

    // Función auxiliar para convertir createdAt/updatedAt
    DateTime? _parseDateTime(dynamic value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      if (value is String) return DateTime.parse(value);
      // Si es Timestamp de Firestore
      if (value.runtimeType.toString() == 'Timestamp') {
        return value.toDate();
      }
      return null;
    }

    return PostulacionModel(
      id: map['id'] ?? '',
      ofertaId: map['ofertaId'] ?? '',
      studentId: map['studentId'] ?? '',
      estado: estadoEnum,
      motivoRechazo: map['motivoRechazo'],
      createdAt: _parseDateTime(map['createdAt']) ?? DateTime.now(),
      updatedAt: _parseDateTime(map['updatedAt']),
      syncStatus: map['syncStatus'] ?? 'synced',
    );
  }

  /// Copia el modelo con cambios
  PostulacionModel copyWith({
    String? id,
    String? ofertaId,
    String? studentId,
    PostulacionEstado? estado,
    String? motivoRechazo,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return PostulacionModel(
      id: id ?? this.id,
      ofertaId: ofertaId ?? this.ofertaId,
      studentId: studentId ?? this.studentId,
      estado: estado ?? this.estado,
      motivoRechazo: motivoRechazo ?? this.motivoRechazo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  /// Verifica si la postulación fue rechazada
  bool get fueRechazada => estado == PostulacionEstado.rechazado;

  /// Verifica si fue aprobada
  bool get fueAprobada => estado == PostulacionEstado.aprobado;

  /// Verifica si está preseleccionada
  bool get estaPreseleccionada => estado == PostulacionEstado.preseleccionado;

  /// Verifica si necesita sincronización (pendingSync o valor legado pending)
  bool get necesitaSincronizacion =>
      syncStatus == AppStates.syncStatusPendingSync || syncStatus == 'pending';

  String get etiquetaSincronizacion =>
      necesitaSincronizacion ? AppStates.syncPendingLabel : '';
}
