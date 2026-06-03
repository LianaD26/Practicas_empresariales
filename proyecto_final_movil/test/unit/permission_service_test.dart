import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_final_movil/models/user_model.dart';
import 'package:proyecto_final_movil/services/permission_service.dart';

void main() {
  final permissionService = PermissionService();

  UserModel createUser({
    required String role,
    required UserStatus status,
  }) {
    return UserModel(
      uid: '1',
      email: 'test@test.com',
      displayName: 'Test',
      role: role,
      status: status,
      createdAt: DateTime.now(),
    );
  }

  test('Usuario estudiante activo puede aplicar a una oferta', () {
    final user = createUser(
      role: 'student',
      status: UserStatus.active,
    );

    expect(
      permissionService.canApplyToOffer(user),
      true,
    );
  });

  test('Usuario pendingApproval no puede aplicar a una oferta', () {
    final user = createUser(
      role: 'student',
      status: UserStatus.pendingApproval,
    );

    expect(
      permissionService.canApplyToOffer(user),
      false,
    );
  });

  test('Usuario coordinador activo puede aprobar postulaciones', () {
    final user = createUser(
      role: 'coordinator',
      status: UserStatus.active,
    );

    expect(
      permissionService.canApproveApplication(user),
      true,
    );
  });

  test('Usuario estudiante no puede aprobar postulaciones', () {
    final user = createUser(
      role: 'student',
      status: UserStatus.active,
    );

    expect(
      permissionService.canApproveApplication(user),
      false,
    );
  });
}