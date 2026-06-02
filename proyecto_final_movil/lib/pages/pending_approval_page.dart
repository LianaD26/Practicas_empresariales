import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

/// Página que se muestra cuando la cuenta está pendiente de aprobación
/// El usuario puede ver la app pero no puede realizar acciones
class PendingApprovalPage extends StatefulWidget {
  final UserModel user;

  const PendingApprovalPage({
    super.key,
    required this.user,
  });

  @override
  State<PendingApprovalPage> createState() => _PendingApprovalPageState();
}

class _PendingApprovalPageState extends State<PendingApprovalPage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta Pendiente'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _authService.signOut(),
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono de reloj/espera
              Icon(
                Icons.schedule_outlined,
                size: 80,
                color: Colors.amber.shade400,
              ),
              const SizedBox(height: 24),

              // Título
              Text(
                'Tu Cuenta Está Pendiente de Aprobación',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
              ),
              const SizedBox(height: 16),

              // Descripción
              Text(
                'Gracias por registrarte en nuestra plataforma. '
                'Tu cuenta está siendo revisada por un administrador.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
              ),
              const SizedBox(height: 32),

              // Información del usuario
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  border: Border.all(color: Colors.amber.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información de tu cuenta:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('Nombre:', widget.user.displayName),
                    _buildInfoRow('Email:', widget.user.email),
                    _buildInfoRow('Rol:', _getRoleName(widget.user.role)),
                    _buildInfoRow('Fecha de Registro:', _formatDate(widget.user.createdAt)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Información de qué esperar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Próximos pasos:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Recibirás un correo cuando tu cuenta sea aprobada\n'
                      '• Podrás acceder a todas las funciones de la plataforma\n'
                      '• El proceso generalmente toma 24-48 horas\n'
                      '• Contacta al coordinador si tienes dudas',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Botón para cerrar sesión
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _authService.signOut();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Cerrar Sesión'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget auxiliar para mostrar información
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Obtiene el nombre del rol
  String _getRoleName(String role) {
    switch (role) {
      case 'student':
        return 'Estudiante';
      case 'company':
        return 'Empresa';
      case 'coordinator':
        return 'Coordinador';
      default:
        return 'Usuario';
    }
  }

  /// Formatea la fecha
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
