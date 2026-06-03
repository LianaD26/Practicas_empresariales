import '../core/map_parsers.dart';

/// Estados posibles de una oferta de práctica
enum OfertaEstado { borrador, publicada, cerrado }

/// Modelo de Oferta de Práctica
class OfertaModel {
  final String id;
  final String titulo;
  final String descripcion;
  final String empresaId; // ID de la empresa que publica
  final OfertaEstado estado;
  final DateTime fechaLimite;
  final int vacantes; // Número de vacantes disponibles
  final String? ubicacion;
  final String? areaPractica; // Área o departamento
  final String? requisitos;
  final DateTime createdAt;
  final DateTime? updatedAt;

  OfertaModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.empresaId,
    this.estado = OfertaEstado.borrador,
    required this.fechaLimite,
    this.vacantes = 1,
    this.ubicacion,
    this.areaPractica,
    this.requisitos,
    required this.createdAt,
    this.updatedAt,
  });

  /// Convierte el modelo a JSON para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'empresaId': empresaId,
      'estado': estado.toString().split('.').last, // 'borrador', 'publicada', 'cerrado'
      'fechaLimite': fechaLimite,
      'vacantes': vacantes,
      'ubicacion': ubicacion,
      'areaPractica': areaPractica,
      'requisitos': requisitos,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// Crea un modelo desde un mapa de Firestore
  factory OfertaModel.fromMap(Map<String, dynamic> map) {
    // Convertir string de estado a enum
    OfertaEstado estadoEnum = OfertaEstado.borrador;
    if (map['estado'] != null) {
      try {
        estadoEnum = OfertaEstado.values.firstWhere(
          (e) => e.toString().split('.').last == map['estado'],
          orElse: () => OfertaEstado.borrador,
        );
      } catch (e) {
        estadoEnum = OfertaEstado.borrador;
      }
    }

    return OfertaModel(
      id: map['id'] ?? '',
      titulo: map['titulo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      empresaId: map['empresaId'] ?? '',
      estado: estadoEnum,
      fechaLimite: parseMapDateTime(
        map['fechaLimite'],
        defaultValue: DateTime.now().add(const Duration(days: 30)),
      ),
      vacantes: map['vacantes'] ?? 1,
      ubicacion: map['ubicacion'],
      areaPractica: map['areaPractica'],
      requisitos: map['requisitos'],
      createdAt: parseMapDateTime(map['createdAt']),
      updatedAt: parseMapDateTimeNullable(map['updatedAt']),
    );
  }

  /// Copia el modelo con cambios
  OfertaModel copyWith({
    String? id,
    String? titulo,
    String? descripcion,
    String? empresaId,
    OfertaEstado? estado,
    DateTime? fechaLimite,
    int? vacantes,
    String? ubicacion,
    String? areaPractica,
    String? requisitos,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OfertaModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      empresaId: empresaId ?? this.empresaId,
      estado: estado ?? this.estado,
      fechaLimite: fechaLimite ?? this.fechaLimite,
      vacantes: vacantes ?? this.vacantes,
      ubicacion: ubicacion ?? this.ubicacion,
      areaPractica: areaPractica ?? this.areaPractica,
      requisitos: requisitos ?? this.requisitos,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Verifica si la oferta está cerrada
  bool get estaCerrada => estado == OfertaEstado.cerrado;

  /// Verifica si la oferta está publicada
  bool get estaPublicada => estado == OfertaEstado.publicada;

  /// Verifica si la oferta está en borrador
  bool get estaBorrador => estado == OfertaEstado.borrador;

  /// Verifica si la oferta ha pasado su fecha límite
  bool get hataSuperadoFechaLimite => DateTime.now().isAfter(fechaLimite);
}
