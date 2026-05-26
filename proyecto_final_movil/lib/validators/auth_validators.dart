import 'package:email_validator/email_validator.dart';

class AuthValidators {
  /// Valida si el email es correcto
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es requerido';
    }

    if (!EmailValidator.validate(value)) {
      return 'Ingrese un correo electrónico válido';
    }

    return null;
  }

  /// Valida si la contraseña cumple los requisitos
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    // Requisitos adicionales (opcional)
    if (!_hasUpperCase(value)) {
      return 'La contraseña debe contener al menos una mayúscula';
    }

    if (!_hasLowerCase(value)) {
      return 'La contraseña debe contener al menos una minúscula';
    }

    if (!_hasNumber(value)) {
      return 'La contraseña debe contener al menos un número';
    }

    return null;
  }

  /// Valida si la contraseña de confirmación coincide
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirme la contraseña';
    }

    if (value != password) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  /// Valida si el nombre no está vacío
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es requerido';
    }

    if (value.length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }

    if (value.length > 50) {
      return 'El nombre no puede exceder 50 caracteres';
    }

    return null;
  }

  /// Valida si el campo es requerido
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    return null;
  }

  /// Verifica si contiene mayúsculas
  static bool _hasUpperCase(String str) {
    return str.contains(RegExp(r'[A-Z]'));
  }

  /// Verifica si contiene minúsculas
  static bool _hasLowerCase(String str) {
    return str.contains(RegExp(r'[a-z]'));
  }

  /// Verifica si contiene números
  static bool _hasNumber(String str) {
    return str.contains(RegExp(r'[0-9]'));
  }

  /// Valida una contraseña sin requisitos estrictos (más permisiva)
  static String? validatePasswordSimple(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    return null;
  }
}
