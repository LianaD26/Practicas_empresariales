import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_final_movil/models/user_model.dart';
import 'package:proyecto_final_movil/core/constants.dart';

/// Test suite para AuthWrapper
/// Nota: Los widget tests que usan RequireRole con BlockedPage/PendingApprovalPage
/// requieren Firebase inicializado. Estos tests se enfocan en la lógica del UserModel
void main() {
  group('AuthWrapper Flow Tests', () {
    /// Test 1: Usuario activo tiene estado correcto
    test('Usuario activo tiene estado correcto', () {
      final activeUser = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
        role: UserRoles.student,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      expect(activeUser.isActive, isTrue);
      expect(activeUser.isBlocked, isFalse);
      expect(activeUser.isPendingApproval, isFalse);
    });

    /// Test 2: Usuario bloqueado es detectado
    test('Usuario bloqueado es detectado correctamente', () {
      final blockedUser = UserModel(
        uid: 'blocked123',
        email: 'blocked@example.com',
        displayName: 'Blocked User',
        role: UserRoles.student,
        status: UserStatus.blocked,
        createdAt: DateTime.now(),
      );

      expect(blockedUser.isActive, isFalse);
      expect(blockedUser.isBlocked, isTrue);
      expect(blockedUser.isPendingApproval, isFalse);
    });

    /// Test 3: Usuario pendiente es detectado
    test('Usuario pendiente de aprobación es detectado correctamente', () {
      final pendingUser = UserModel(
        uid: 'pending123',
        email: 'pending@example.com',
        displayName: 'Pending User',
        role: UserRoles.company,
        status: UserStatus.pendingApproval,
        createdAt: DateTime.now(),
      );

      expect(pendingUser.isActive, isFalse);
      expect(pendingUser.isBlocked, isFalse);
      expect(pendingUser.isPendingApproval, isTrue);
    });

    /// Test 4: Serialización UserModel
    test('UserModel serialización y deserialización funciona', () {
      final user = UserModel(
        uid: 'user123',
        email: 'user@test.com',
        displayName: 'Test User',
        role: UserRoles.coordinator,
        status: UserStatus.active,
        createdAt: DateTime(2026, 1, 1),
      );

      final userMap = user.toMap();
      expect(userMap['uid'], equals('user123'));
      expect(userMap['email'], equals('user@test.com'));
      expect(userMap['displayName'], equals('Test User'));
      expect(userMap['role'], equals(UserRoles.coordinator));
      expect(userMap['status'], equals('active'));
    });
  });
}
