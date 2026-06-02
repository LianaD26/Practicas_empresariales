import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../pages/student_home_page.dart';
import '../pages/company_home_page.dart';
import '../pages/coordinator_home_page.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authService = AuthService();

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      try {
        await _authService.signOut();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Redirigir según el rol del usuario
    switch (widget.user.role) {
      case 'student':
        return StudentHomePage(user: widget.user);
      case 'company':
        return CompanyHomePage(user: widget.user);
      case 'coordinator':
        return CoordinatorHomePage(user: widget.user);
      default:
        return Scaffold(
          appBar: AppBar(
            title: const Text('Inicio'),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: _handleLogout,
                tooltip: 'Cerrar Sesión',
              ),
            ],
          ),
          body: Center(
            child: Text('Rol desconocido: ${widget.user.role}'),
          ),
        );
    }
  }
}
