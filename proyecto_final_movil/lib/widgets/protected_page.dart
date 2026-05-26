import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

/// Widget que protege una página verificando:
/// 1. Que el usuario esté autenticado
/// 2. Que el usuario tenga un rol específico (opcional)
/// 3. Que el usuario esté activo (opcional)
/// 
/// Uso:
/// ProtectedPage(
///   requiredRole: 'admin',
///   child: AdminPage(),
/// )
class ProtectedPage extends StatelessWidget {
  final Widget child;
  final String? requiredRole;
  final bool requireActive;
  final Widget? unauthorizedWidget;
  final AuthService _authService = AuthService();

  ProtectedPage({
    super.key,
    required this.child,
    this.requiredRole,
    this.requireActive = true,
    this.unauthorizedWidget,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: _authService.getCurrentUserModelStream(),
      builder: (context, snapshot) {
        // Mientras se cargan los datos
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Si hay error o sin datos
        if (!snapshot.hasData || snapshot.data == null) {
          return unauthorizedWidget ??
              _buildUnauthorizedPage(
                context,
                'Usuario no autenticado',
              );
        }

        final user = snapshot.data!;

        // Verificar si el usuario está activo
        if (requireActive && !user.isActive) {
          return unauthorizedWidget ??
              _buildUnauthorizedPage(
                context,
                'Tu cuenta ha sido desactivada',
              );
        }

        // Verificar si tiene el rol requerido
        if (requiredRole != null && user.role != requiredRole) {
          return unauthorizedWidget ??
              _buildUnauthorizedPage(
                context,
                'No tienes permisos para acceder a esta página.\nRol requerido: ${_formatRole(requiredRole!)}',
              );
        }

        // Si pasa todas las validaciones, mostrar la página
        return child;
      },
    );
  }

  Widget _buildUnauthorizedPage(BuildContext context, String message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceso Denegado'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Acceso Denegado',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRole(String role) {
    switch (role) {
      case 'admin':
        return 'Administrador';
      case 'moderator':
        return 'Moderador';
      case 'user':
        return 'Usuario';
      default:
        return role;
    }
  }
}
