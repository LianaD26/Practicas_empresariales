import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

/// Página principal para empresas
/// Pueden crear/editar ofertas, ver postulaciones y preseleccionar candidatos
class CompanyHomePage extends StatefulWidget {
  final UserModel user;

  const CompanyHomePage({
    super.key,
    required this.user,
  });

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
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
        title: const Text('Inicio - Empresa'),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Mis Ofertas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Postulantes',
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
        return _buildHomeTab();
      case 1:
        return _buildOffersTab();
      case 2:
        return _buildApplicantsTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
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
                  colors: [Colors.orange, Colors.deepOrange],
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

          // Información útil
          const Text(
            '¿Qué puedes hacer?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Acciones rápidas
          _buildActionCard(
            icon: Icons.work_outline,
            title: 'Crear Oferta',
            description: 'Publica una nueva oferta de práctica',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Crear oferta en desarrollo')),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildActionCard(
            icon: Icons.work,
            title: 'Mis Ofertas',
            description: 'Gestiona tus ofertas de práctica',
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          const SizedBox(height: 12),

          _buildActionCard(
            icon: Icons.people,
            title: 'Ver Postulantes',
            description: 'Revisa los candidatos a tus ofertas',
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

  Widget _buildOffersTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Mis Ofertas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Gestiona tus ofertas de práctica',
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

  Widget _buildApplicantsTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'Postulantes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Candidatos a tus ofertas',
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
            value: 'Empresa',
            icon: Icons.business,
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
          leading: Icon(icon, size: 32, color: Colors.orange),
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
        leading: Icon(icon, color: Colors.orange),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
