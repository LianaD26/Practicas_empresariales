import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

/// Página principal para coordinadores
/// Pueden aprobar/rechazar postulaciones, gestionar usuarios y ver todo
class CoordinatorHomePage extends StatefulWidget {
  final UserModel user;

  const CoordinatorHomePage({
    super.key,
    required this.user,
  });

  @override
  State<CoordinatorHomePage> createState() => _CoordinatorHomePageState();
}

class _CoordinatorHomePageState extends State<CoordinatorHomePage> {
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard - Coordinador'),
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
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Postulaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return _buildApplicationsTab();
      case 2:
        return _buildUsersTab();
      case 3:
        return _buildReportsTab();
      case 4:
        return _buildProfileTab();
      default:
        return _buildDashboardTab();
    }
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tarjeta de bienvenida
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.tealAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.user.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Estadísticas rápidas
          const Text(
            'Estadísticas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          _buildStatCard(
            icon: Icons.folder_special,
            title: 'Postulaciones',
            value: '0',
            color: Colors.blue,
          ),
          const SizedBox(height: 12),

          _buildStatCard(
            icon: Icons.people,
            title: 'Usuarios',
            value: '0',
            color: Colors.green,
          ),
          const SizedBox(height: 12),

          _buildStatCard(
            icon: Icons.work,
            title: 'Ofertas',
            value: '0',
            color: Colors.orange,
          ),
          const SizedBox(height: 24),

          // Acciones rápidas
          const Text(
            'Acciones Rápidas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          _buildActionCard(
            icon: Icons.check_circle,
            title: 'Revisar Postulaciones',
            description: 'Aprueba o rechaza postulaciones pendientes',
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          const SizedBox(height: 12),

          _buildActionCard(
            icon: Icons.people,
            title: 'Gestionar Usuarios',
            description: 'Administra permisos y estado de cuentas',
            onTap: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Postulaciones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Revisa y aprueba postulaciones',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            const Text('Página en desarrollo...'),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Gestión de Usuarios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Administra permisos y estado de cuentas',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            const Text('Página en desarrollo...'),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assessment, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Reportes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Análisis y estadísticas',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            const Text('Página en desarrollo...'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mi Perfil',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildProfileCard(
            label: 'Nombre',
            value: widget.user.displayName,
            icon: Icons.person,
          ),
          const SizedBox(height: 12),

          _buildProfileCard(
            label: 'Email',
            value: widget.user.email,
            icon: Icons.email,
          ),
          const SizedBox(height: 12),

          _buildProfileCard(
            label: 'Rol',
            value: 'Coordinador',
            icon: Icons.admin_panel_settings,
          ),
          const SizedBox(height: 12),

          _buildProfileCard(
            label: 'Estado',
            value: widget.user.status.toString().split('.').last,
            icon: Icons.info,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32, color: color),
        title: Text(title),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: Icon(icon, size: 32, color: Colors.teal),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
