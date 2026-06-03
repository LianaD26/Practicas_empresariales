import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../widgets/require_role.dart';
import '../repositories/user_repository.dart';

/// Página principal para Super Administrador
/// Puede cambiar estados de usuarios
class SuperAdminHomePage extends StatefulWidget {
  final UserModel user;

  const SuperAdminHomePage({
    super.key,
    required this.user,
  });

  @override
  State<SuperAdminHomePage> createState() => _SuperAdminHomePageState();
}

class _SuperAdminHomePageState extends State<SuperAdminHomePage> {
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
    return RequireRole(
      user: widget.user,
      allowedRoles: const [UserRoles.superadmin],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard - Super Admin'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.deepPurple,
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
              icon: Icon(Icons.people),
              label: 'Gestionar Usuarios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return _buildManageUsersTab();
      case 2:
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
                  colors: [Colors.deepPurple, Colors.purple],
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
                    'Bienvenido Super Admin',
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

          // Acciones principales
          const Text(
            'Opciones de Administración',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          _buildActionCard(
            icon: Icons.people,
            title: 'Gestionar Usuarios',
            description: 'Asignar roles, cambiar estados, bloquear cuentas',
            color: Colors.deepPurple,
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          const SizedBox(height: 12),

          _buildActionCard(
            icon: Icons.security,
            title: 'Permisos y Roles',
            description: 'SuperAdmin, Coordinador, Empresa, Estudiante',
            color: Colors.indigo,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Función en desarrollo')),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildActionCard(
            icon: Icons.report,
            title: 'Reportes',
            description: 'Estadísticas y análisis del sistema',
            color: Colors.blue,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Función en desarrollo')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildManageUsersTab() {
    return StreamBuilder<List<UserModel>>(
      stream: context.read<UserRepository>().getAllUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text(
                    'No hay usuarios',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }

        final users = snapshot.data!;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Gestión de Usuarios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: ${users.length} usuarios',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ...users.map((user) => _buildUserCard(user)),
          ],
        );
      },
    );
  }

  Widget _buildUserCard(UserModel user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Icon(
          user.role == 'superadmin'
              ? Icons.security
              : user.role == 'coordinator'
                  ? Icons.admin_panel_settings
                  : user.role == 'company'
                      ? Icons.business
                      : Icons.school,
          color: Colors.deepPurple,
        ),
        title: Text(user.displayName),
        subtitle: Text('${user.email} • ${user.role}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 16),
                const Text('Cambiar Estado:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildStatusButton(
                        label: 'Activo',
                        isSelected: user.status == UserStatus.active,
                        onPressed: () => _updateUserStatus(user.uid, UserStatus.active),
                      ),
                      const SizedBox(width: 8),
                      _buildStatusButton(
                        label: 'Pendiente',
                        isSelected: user.status == UserStatus.pendingApproval,
                        onPressed: () => _updateUserStatus(user.uid, UserStatus.pendingApproval),
                      ),
                      const SizedBox(width: 8),
                      _buildStatusButton(
                        label: 'Bloqueado',
                        isSelected: user.status == UserStatus.blocked,
                        onPressed: () => _updateUserStatus(user.uid, UserStatus.blocked),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Estado Actual: ${user.status.toString().split('.').last}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Text(
                  'Creado: ${user.createdAt.toLocal().toString().split('.')[0]}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildStatusButton({
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
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
            value: 'Super Administrador',
            icon: Icons.security,
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
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: Icon(icon, size: 32, color: color),
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
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Future<void> _updateUserStatus(String uid, UserStatus status) async {
    try {
      await context.read<UserRepository>().updateUserStatus(uid, status);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Estado actualizado a ${status.toString().split('.').last}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
