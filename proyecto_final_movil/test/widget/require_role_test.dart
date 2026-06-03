import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_final_movil/core/constants.dart';
import 'package:proyecto_final_movil/models/user_model.dart';
import 'package:proyecto_final_movil/widgets/require_role.dart';

void main() {
  group('RequireRole Tests', () {
    /// Test 1: RequireRole permite acceso a usuario con rol correcto
    testWidgets('Muestra contenido cuando usuario tiene rol permitido',
        (WidgetTester tester) async {
      final user = UserModel(
        uid: 'user123',
        email: 'company@test.com',
        displayName: 'Test Company',
        role: UserRoles.company,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RequireRole(
            user: user,
            allowedRoles: const [UserRoles.company],
            child: const Scaffold(
              body: Center(
                child: Text('Company Dashboard'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Company Dashboard'), findsOneWidget);
    });

    /// Test 2: RequireRole muestra acceso denegado para rol incorrecto
    testWidgets('Muestra acceso denegado cuando rol no es permitido',
        (WidgetTester tester) async {
      final user = UserModel(
        uid: 'student123',
        email: 'student@test.com',
        displayName: 'Test Student',
        role: UserRoles.student,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RequireRole(
            user: user,
            allowedRoles: const [UserRoles.company],
            child: const Scaffold(
              body: Center(
                child: Text('Company Only'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Company Only'), findsNothing);
      expect(find.byType(AppBar), findsOneWidget);
    });

    /// Test 3: RequireRole permite múltiples roles
    testWidgets('Permite acceso cuando usuario tiene uno de varios roles',
        (WidgetTester tester) async {
      final user = UserModel(
        uid: 'coordinator123',
        email: 'coord@test.com',
        displayName: 'Coordinator',
        role: UserRoles.coordinator,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RequireRole(
            user: user,
            allowedRoles: const [
              UserRoles.coordinator,
              UserRoles.superadmin,
            ],
            child: const Scaffold(
              body: Center(
                child: Text('Admin Content'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Admin Content'), findsOneWidget);
    });

    /// Test 4: RequireRole bloquea acceso a usuario inactivo
        test('Bloquea acceso a usuario inactivo (pendiente)', () {
          final user = UserModel(
            uid: 'pending123',
            email: 'pending@test.com',
            displayName: 'Pending User',
            role: UserRoles.student,
            status: UserStatus.pendingApproval,
            createdAt: DateTime.now(),
          );

          expect(user.isPendingApproval, isTrue);
          expect(user.isActive, isFalse);
          expect(user.role, equals(UserRoles.student));
        });
  });
}
