import '../models/documento_model.dart';

class DocumentoValidators {
  /// Valida el nombre del documento
  static String? validateNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre del documento es requerido';
    }
    if (value.length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    }
    if (value.length > 100) {
      return 'El nombre no puede exceder 100 caracteres';
    }
    return null;
  }

  /// Valida que se haya seleccionado un tipo de documento
  static String? validateTipo(TipoDocumento? value) {
    if (value == null) {
      return 'Debe seleccionar un tipo de documento';
    }
    return null;
  }

  /// Valida la URL del documento
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'La URL del documento es requerida';
    }
    final uri = Uri.tryParse(value);
    if (uri == null ||
        !uri.hasAbsolutePath ||
        (!uri.scheme.startsWith('http') && !uri.scheme.startsWith('https'))) {
      return 'Ingrese una URL válida (debe comenzar con http:// o https://)';
    }
    return null;
  }

  /// Valida el ID del usuario propietario
  static String? validateUsuarioId(String? value) {
    if (value == null || value.isEmpty) {
      return 'El usuario es requerido';
    }
    return null;
  }
}
