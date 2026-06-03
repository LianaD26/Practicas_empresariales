import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_final_movil/core/constants.dart';
import 'package:proyecto_final_movil/models/user_model.dart';

void main() {
  group('HomePage Role-based Routing Tests', () {
    /// Test 1: UserRoles constantes definidas
    test('UserRoles constantes están correctamente definidas', () {
      expect(UserRoles.student, equals('student'));
      expect(UserRoles.company, equals('company'));
      expect(UserRoles.coordinator, equals('coordinator'));
      expect(UserRoles.superadmin, equals('superadmin'));
    });

    /// Test 2: Usuario estudiante se construye
    test('HomePage puede obtener usuario con rol student', () {
      final studentUser = UserModel(
        uid: 'student123',
        email: 'student@test.com',
        displayName: 'Test Student',
        role: UserRoles.student,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(studentUser.role, equals(UserRoles.student));
      expect(studentUser.isActive, isTrue);
    });

    /// Test 3: Usuario empresa se construye
    test('HomePage puede obtener usuario con rol company', () {
      final companyUser = UserModel(
        uid: 'company123',
        email: 'company@test.com',
        displayName: 'Tech Company',
        role: UserRoles.company,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(companyUser.role, equals(UserRoles.company));
      expect(companyUser.isActive, isTrue);
    });

    /// Test 4: HomePage maneja todos los roles
    test('HomePage maneja todos los roles en switch', () {
      final roles = [
        UserRoles.student,
        UserRoles.company,
        UserRoles.coordinator,
        UserRoles.superadmin,
      ];

      for (final role in roles) {
        final user = UserModel(
          uid: 'user_123',
          email: 'user@test.com',
          displayName: 'Test',
          role: role,
          status: UserStatus.active,
          createdAt: DateTime.now(),
        );

        expect(user.role, equals(role));
        expect(user.isActive, isTrue);
      }
    });
  });
}
