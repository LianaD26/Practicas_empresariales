import '../models/follow-up_model.dart';

class SeguimientoValidators {
  /// Valida el comentario del seguimiento
  static String? validateComentario(String? value) {
    if (value == null || value.isEmpty) {
      return 'El comentario es requerido';
    }
    if (value.length < 5) {
      return 'El comentario debe tener al menos 5 caracteres';
    }
    if (value.length > 500) {
      return 'El comentario no puede exceder 500 caracteres';
    }
    return null;
  }

  /// Valida que se haya seleccionado un estado
  static String? validateEstado(EstadoSeguimiento? value) {
    if (value == null) {
      return 'Debe seleccionar un estado';
    }
    return null;
  }

  /// Valida el ID de la postulación asociada
  static String? validatePostulacionId(String? value) {
    if (value == null || value.isEmpty) {
      return 'La postulación es requerida';
    }
    return null;
  }
}
