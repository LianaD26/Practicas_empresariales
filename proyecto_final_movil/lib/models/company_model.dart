import '../core/map_parsers.dart';

/// Modelo de Empresa
class EmpresaModel {
  final String id;
  final String nombre;
  final String? descripcion;
  final String? ubicacion;
  final String? contacto; // Email o teléfono
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  EmpresaModel({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.ubicacion,
    this.contacto,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  /// Convierte el modelo a JSON para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'contacto': contacto,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
    };
  }

  /// Crea un modelo desde un mapa de Firestore
  factory EmpresaModel.fromMap(Map<String, dynamic> map) {
    return EmpresaModel(
      id: map['id'] ?? '',
      nombre: map['nombre'] ?? '',
      descripcion: map['descripcion'],
      ubicacion: map['ubicacion'],
      contacto: map['contacto'],
      createdAt: parseMapDateTime(map['createdAt']),
      updatedAt: parseMapDateTimeNullable(map['updatedAt']),
      isActive: map['isActive'] ?? true,
    );
  }

  /// Copia el modelo con cambios
  EmpresaModel copyWith({
    String? id,
    String? nombre,
    String? descripcion,
    String? ubicacion,
    String? contacto,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return EmpresaModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      ubicacion: ubicacion ?? this.ubicacion,
      contacto: contacto ?? this.contacto,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
