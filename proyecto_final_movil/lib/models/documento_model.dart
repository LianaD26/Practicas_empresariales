/// Tipos válidos de documento
enum TipoDocumento {
  cartaDePresentacion('carta_de_presentacion', 'Carta de Presentación'),
  hojaDeVida('hoja_de_vida', 'Hoja de Vida');

  final String value;
  final String label;

  const TipoDocumento(this.value, this.label);

  /// Convierte un String de Firestore al enum
  static TipoDocumento fromValue(String value) {
    return TipoDocumento.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TipoDocumento.hojaDeVida,
    );
  }
}

class DocumentoModel {
  final String id;
  final String nombre;
  final TipoDocumento tipo;
  final String url;
  final DateTime fechaSubida;
  final String usuarioId;

  DocumentoModel({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.url,
    required this.fechaSubida,
    required this.usuarioId,
  });

  /// Convierte el modelo a JSON para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo.value,
      'url': url,
      'fechaSubida': fechaSubida.toIso8601String(),
      'usuarioId': usuarioId,
    };
  }

  /// Crea un modelo desde un mapa de Firestore
  factory DocumentoModel.fromMap(Map<String, dynamic> map) {
    return DocumentoModel(
      id: map['id'] ?? '',
      nombre: map['nombre'] ?? '',
      tipo: TipoDocumento.fromValue(map['tipo'] ?? 'hoja_de_vida'),
      url: map['url'] ?? '',
      fechaSubida: map['fechaSubida'] != null
          ? DateTime.parse(map['fechaSubida'] is String
              ? map['fechaSubida']
              : map['fechaSubida'].toDate().toIso8601String())
          : DateTime.now(),
      usuarioId: map['usuarioId'] ?? '',
    );
  }

  /// Copia el modelo con cambios
  DocumentoModel copyWith({
    String? id,
    String? nombre,
    TipoDocumento? tipo,
    String? url,
    DateTime? fechaSubida,
    String? usuarioId,
  }) {
    return DocumentoModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      url: url ?? this.url,
      fechaSubida: fechaSubida ?? this.fechaSubida,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }
}
