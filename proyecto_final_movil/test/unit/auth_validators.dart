import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_final_movil/validators/auth_validators.dart';

void main() {

  test('Email inválido retorna error', () {
    final result =
        AuthValidators.validateEmail(
          'correo_invalido',
        );

    expect(
      result,
      'Ingrese un correo electrónico válido',
    );
  });

  test('Contraseña sin mayúscula retorna error', () {
    final result =
        AuthValidators.validatePassword(
          'password123',
        );

    expect(
      result,
      'La contraseña debe contener al menos una mayúscula',
    );
  });
}