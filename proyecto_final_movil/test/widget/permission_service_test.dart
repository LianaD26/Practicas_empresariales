import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_final_movil/core/constants.dart';
import 'package:proyecto_final_movil/models/user_model.dart';
import 'package:proyecto_final_movil/services/permission_service.dart';

void main() {
  group('PermissionService Tests', () {
    final permissionService = PermissionService();

    /// Test 1: Verifica que solo superadmin puede cambiar roles
    test('Solo superadmin puede cambiar roles', () {
      // Superadmin activo SÍ puede cambiar roles
      final superadmin = UserModel(
        uid: 'admin123',
        email: 'admin@test.com',
        displayName: 'Super Admin',
        role: UserRoles.superadmin,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canChangeRoles(superadmin), isTrue);

      // Otros roles NO pueden cambiar roles
      final coordinator = UserModel(
        uid: 'coord123',
        email: 'coord@test.com',
        displayName: 'Coordinator',
        role: UserRoles.coordinator,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canChangeRoles(coordinator), isFalse);

      // Si superadmin está bloqueado, tampoco puede cambiar roles
      final blockedAdmin = UserModel(
        uid: 'admin456',
        email: 'blocked@test.com',
        displayName: 'Blocked Admin',
        role: UserRoles.superadmin,
        status: UserStatus.blocked,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canChangeRoles(blockedAdmin), isFalse);
    });

    /// Test 2: Verifica que solo companies pueden crear ofertas
    test('Solo companies pueden crear ofertas', () {
      // Company activa SÍ puede crear ofertas
      final company = UserModel(
        uid: 'company123',
        email: 'company@test.com',
        displayName: 'Tech Corp',
        role: UserRoles.company,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canCreateOffer(company), isTrue);

      // Estudiante NO puede crear ofertas
      final student = UserModel(
        uid: 'student123',
        email: 'student@test.com',
        displayName: 'Student',
        role: UserRoles.student,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canCreateOffer(student), isFalse);

      // Company inactiva NO puede crear ofertas
      final inactiveCompany = UserModel(
        uid: 'company456',
        email: 'inactive@test.com',
        displayName: 'Inactive Corp',
        role: UserRoles.company,
        status: UserStatus.pendingApproval,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canCreateOffer(inactiveCompany), isFalse);
    });

    /// Test 3: Verifica que solo coordinadores pueden aprobar postulaciones
    test('Solo coordinadores pueden aprobar postulaciones', () {
      // Coordinador activo SÍ puede aprobar
      final coordinator = UserModel(
        uid: 'coord123',
        email: 'coord@test.com',
        displayName: 'Coordinator',
        role: UserRoles.coordinator,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canApproveApplication(coordinator), isTrue);
      expect(permissionService.canRejectApplication(coordinator), isTrue);

      // Empresa NO puede aprobar (aunque vea postulaciones)
      final company = UserModel(
        uid: 'company123',
        email: 'company@test.com',
        displayName: 'Company',
        role: UserRoles.company,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canApproveApplication(company), isFalse);

      // Estudiante NO puede aprobar
      final student = UserModel(
        uid: 'student123',
        email: 'student@test.com',
        displayName: 'Student',
        role: UserRoles.student,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canApproveApplication(student), isFalse);
    });

    /// Test 4: Verifica que solo estudiantes pueden postularse
    test('Solo estudiantes activos pueden postularse', () {
      // Estudiante activo SÍ puede postularse
      final student = UserModel(
        uid: 'student123',
        email: 'student@test.com',
        displayName: 'Student',
        role: UserRoles.student,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canApplyToOffer(student), isTrue);

      // Empresa NO puede postularse
      final company = UserModel(
        uid: 'company123',
        email: 'company@test.com',
        displayName: 'Company',
        role: UserRoles.company,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canApplyToOffer(company), isFalse);

      // Estudiante pendiente NO puede postularse
      final pendingStudent = UserModel(
        uid: 'student456',
        email: 'pending@test.com',
        displayName: 'Pending Student',
        role: UserRoles.student,
        status: UserStatus.pendingApproval,
        createdAt: DateTime.now(),
      );

      expect(permissionService.canApplyToOffer(pendingStudent), isFalse);
    });
  });
}
