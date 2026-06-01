import 'package:flutter/material.dart';
import '../services/auth_service.dart';

/// Página que se muestra cuando la cuenta del usuario está bloqueada
class BlockedPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  BlockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceso Bloqueado'),
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
              // Ícono de bloqueo
              Icon(
                Icons.lock_outline,
                size: 80,
                color: Colors.red.shade300,
              ),
              const SizedBox(height: 24),

              // Título
              Text(
                'Tu Cuenta Ha Sido Bloqueada',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
              ),
              const SizedBox(height: 16),

              // Descripción
              Text(
                'Tu acceso a la plataforma ha sido suspendido. '
                'Por favor, contacta al coordinador o administrador para más información.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
              ),
              const SizedBox(height: 32),

              // Información adicional
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Motivos posibles:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Violación de políticas de la plataforma\n'
                      '• Comportamiento inadecuado\n'
                      '• Solicitud de revisión administrativa',
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
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
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
}
