import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';
import '../pages/blocked_page.dart';
import '../pages/pending_approval_page.dart';

/// Widget que maneja la lógica de autenticación, redirección por rol y estado
/// - Si no hay usuario autenticado: muestra LoginPage
/// - Si está bloqueado: muestra BlockedPage
/// - Si está pendiente de aprobación: muestra PendingApprovalPage
/// - Si está activo: muestra HomePage (que internamente redirige por rol)
/// - El estado se actualiza en tiempo real con Stream
class AuthWrapper extends StatelessWidget {
  final AuthService _authService = AuthService();

  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.authStateChanges,
      builder: (context, authSnapshot) {
        // Mientras se verifica el estado de autenticación
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Si hay un error
        if (authSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${authSnapshot.error}'),
            ),
          );
        }

        // Si el usuario NO está autenticado
        if (!authSnapshot.hasData || authSnapshot.data == null) {
          return const LoginPage();
        }

        // Si el usuario está autenticado, obtener su perfil de Firestore
        return StreamBuilder<UserModel?>(
          stream: _authService.getCurrentUserModelStream(),
          builder: (context, userSnapshot) {
            // Mientras se cargan datos del usuario
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Si no hay datos del usuario
            if (!userSnapshot.hasData || userSnapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Error cargando perfil del usuario'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _authService.signOut(),
                        child: const Text('Cerrar Sesión'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final user = userSnapshot.data!;

            // Si el usuario está bloqueado
            if (user.isBlocked) {
              return BlockedPage();
            }

            // Si el usuario está pendiente de aprobación
            if (user.isPendingApproval) {
              return PendingApprovalPage(user: user);
            }

            // Si el usuario está activo, mostrar HomePage
            if (user.isActive) {
              return HomePage(user: user);
            }

            // Por defecto
            return const LoginPage();
          },
        );
      },
    );
  }
}
