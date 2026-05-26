import 'package:flutter/material.dart';
import '../widgets/protected_page.dart';

/// Ejemplo de Página de Admin
/// Solo accesible por usuarios con rol 'admin'
class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProtectedPage(
      requiredRole: 'admin',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Panel de Administrador'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Panel de Control',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildAdminCard(
                title: 'Gestionar Usuarios',
                description: 'Ver, editar y desactivar usuarios',
                icon: Icons.people,
                onTap: () {
                  // TODO: Navegar a pantalla de gestión de usuarios
                },
              ),
              const SizedBox(height: 12),
              _buildAdminCard(
                title: 'Reportes',
                description: 'Ver estadísticas y reportes',
                icon: Icons.bar_chart,
                onTap: () {
                  // TODO: Navegar a pantalla de reportes
                },
              ),
              const SizedBox(height: 12),
              _buildAdminCard(
                title: 'Configuración',
                description: 'Configurar parámetros de la aplicación',
                icon: Icons.settings,
                onTap: () {
                  // TODO: Navegar a pantalla de configuración
                },
              ),
              const SizedBox(height: 12),
              _buildAdminCard(
                title: 'Logs y Auditoría',
                description: 'Ver registros de actividades',
                icon: Icons.assignment,
                onTap: () {
                  // TODO: Navegar a pantalla de auditoría
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.deepPurple),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

/// Ejemplo de Página de Moderador
/// Solo accesible por usuarios con rol 'moderator'
class ModeratorPage extends StatelessWidget {
  const ModeratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProtectedPage(
      requiredRole: 'moderator',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Panel de Moderador'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Herramientas de Moderación',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildModeratorCard(
                title: 'Revisar Contenido',
                description: 'Ver contenido pendiente de revisión',
                icon: Icons.visibility,
                onTap: () {
                  // TODO: Navegar a revisión de contenido
                },
              ),
              const SizedBox(height: 12),
              _buildModeratorCard(
                title: 'Reportes de Usuarios',
                description: 'Ver reportes de usuarios problemáticos',
                icon: Icons.flag,
                onTap: () {
                  // TODO: Navegar a reportes
                },
              ),
              const SizedBox(height: 12),
              _buildModeratorCard(
                title: 'Acciones Moderadas',
                description: 'Ver historial de acciones tomadas',
                icon: Icons.history,
                onTap: () {
                  // TODO: Navegar a historial
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeratorCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.orange),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

/// Ejemplo de Página de Usuario Normal
/// Accesible por todos los usuarios autenticados
class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Espacio'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido a tu Espacio',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildUserCard(
              title: 'Mi Perfil',
              description: 'Ver y editar tu perfil',
              icon: Icons.person,
              onTap: () {
                // TODO: Navegar a perfil
              },
            ),
            const SizedBox(height: 12),
            _buildUserCard(
              title: 'Mis Actividades',
              description: 'Ver tu historial de actividades',
              icon: Icons.list,
              onTap: () {
                // TODO: Navegar a actividades
              },
            ),
            const SizedBox(height: 12),
            _buildUserCard(
              title: 'Preferencias',
              description: 'Configurar tus preferencias',
              icon: Icons.tune,
              onTap: () {
                // TODO: Navegar a preferencias
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
