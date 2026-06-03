import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../widgets/require_role.dart';

/// Página principal para estudiantes
/// Pueden ver ofertas, postularse y ver sus postulaciones
class StudentHomePage extends StatefulWidget {
  final UserModel user;

  const StudentHomePage({
    super.key,
    required this.user,
  });

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;
  int? _selectedOfferIndex; // Para rastrear la oferta seleccionada

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
      allowedRoles: const [UserRoles.student],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inicio - Estudiante'),
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
              label: 'Ofertas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_special),
              label: 'Mis Postulaciones',
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
        return _buildHomeTab();
      case 1:
        return _buildOffersTab();
      case 2:
        return _buildApplicationsTab();
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
                  colors: [Colors.deepPurple, Colors.purpleAccent],
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
            icon: Icons.work,
            title: 'Ver Ofertas',
            description: 'Consulta todas las ofertas de práctica disponibles',
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          const SizedBox(height: 12),

          _buildActionCard(
            icon: Icons.folder_special,
            title: 'Mis Postulaciones',
            description: 'Sigue el estado de tus postulaciones',
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
    // Si está viendo el detalle de una oferta
    if (_selectedOfferIndex != null) {
      return _buildOfferDetailView();
    }

    // Listado de ofertas
    final mockOffers = [
      {'id': '1', 'titulo': 'Practicante de Desarrollo Web', 'empresa': 'Tech Corp', 'descripcion': 'Desarrollo de aplicaciones web con Flutter y backend'},
      {'id': '2', 'titulo': 'Practicante de Mobile', 'empresa': 'App Solutions', 'descripcion': 'Desarrollo de aplicaciones móviles nativas'},
      {'id': '3', 'titulo': 'Practicante de QA', 'empresa': 'Quality First', 'descripcion': 'Testing y aseguramiento de calidad'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botón de volver
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: Colors.deepPurple),
                const SizedBox(width: 8),
                const Text('Volver', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Ofertas de Práctica',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mockOffers.length,
            itemBuilder: (context, index) {
              final offer = mockOffers[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(Icons.work_outline, color: Colors.deepPurple),
                  title: Text(offer['titulo']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(offer['empresa']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    setState(() {
                      _selectedOfferIndex = index;
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOfferDetailView() {
    final mockOffers = [
      {
        'id': '1',
        'titulo': 'Practicante de Desarrollo Web',
        'empresa': 'Tech Corp',
        'descripcion': 'Desarrollo de aplicaciones web con Flutter y backend',
        'salario': '0 - Práctica',
        'ubicacion': 'Bogotá, Colombia',
        'duracion': '6 meses',
      },
      {
        'id': '2',
        'titulo': 'Practicante de Mobile',
        'empresa': 'App Solutions',
        'descripcion': 'Desarrollo de aplicaciones móviles nativas',
        'salario': '0 - Práctica',
        'ubicacion': 'Medellín, Colombia',
        'duracion': '6 meses',
      },
      {
        'id': '3',
        'titulo': 'Practicante de QA',
        'empresa': 'Quality First',
        'descripcion': 'Testing y aseguramiento de calidad',
        'salario': '0 - Práctica',
        'ubicacion': 'Cali, Colombia',
        'duracion': '3 meses',
      },
    ];

    final offer = mockOffers[_selectedOfferIndex!];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botón de volver
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOfferIndex = null;
              });
            },
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: Colors.deepPurple),
                const SizedBox(width: 8),
                const Text('Volver', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Tarjeta de oferta
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer['titulo']!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    offer['empresa']!,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 16),
                  // Información de la oferta
                  _buildOfferInfo('Descripción', offer['descripcion']!, Icons.description),
                  const SizedBox(height: 12),
                  _buildOfferInfo('Salario', offer['salario']!, Icons.attach_money),
                  const SizedBox(height: 12),
                  _buildOfferInfo('Ubicación', offer['ubicacion']!, Icons.location_on),
                  const SizedBox(height: 12),
                  _buildOfferInfo('Duración', offer['duracion']!, Icons.schedule),
                  const SizedBox(height: 20),
                  // Botón de postularse
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('¡Postulación registrada!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text('Postularme', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferInfo(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.deepPurple, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botón de volver
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: Colors.deepPurple),
                const SizedBox(width: 8),
                const Text('Volver', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Mis Postulaciones',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Listado de postulaciones
          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Practicante de Desarrollo Web', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Tech Corp - Postulado'),
              trailing: const Chip(label: Text('En revisión'), backgroundColor: Colors.blue),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Practicante de Mobile', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('App Solutions - Postulado'),
              trailing: const Chip(label: Text('Preseleccionado'), backgroundColor: Colors.orange),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text('Practicante de QA', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Quality First - Postulado'),
              trailing: const Chip(label: Text('Rechazado'), backgroundColor: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botón de volver
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: Colors.deepPurple),
                const SizedBox(width: 8),
                const Text('Volver', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),

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
            value: 'Estudiante',
            icon: Icons.badge,
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
          leading: Icon(icon, size: 32, color: Colors.deepPurple),
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
}
