import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';

/// Widget que maneja la lógica de autenticación y redirección
/// - Si no hay usuario autenticado: muestra LoginPage
/// - Si hay usuario autenticado: muestra HomePage
/// - El estado se actualiza en tiempo real con Stream
class AuthWrapper extends StatelessWidget {
  final AuthService _authService = AuthService();

  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        // Mientras se verifica el estado de autenticación
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Si hay un error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        // Si el usuario está autenticado
        if (snapshot.hasData && snapshot.data != null) {
          return const HomePage();
        }

        // Si el usuario NO está autenticado
        return const LoginPage();
      },
    );
  }
}
