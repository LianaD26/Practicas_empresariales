import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/offer_model.dart';
import '../models/postulation_model.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../widgets/require_role.dart';
import 'offer_form_page.dart';
import 'follow-up_list_page.dart';

/// Página principal para empresas
/// Pueden crear/editar ofertas, ver postulaciones y preseleccionar candidatos
class CompanyHomePage extends StatefulWidget {
  final UserModel user;

  const CompanyHomePage({super.key, required this.user});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  int _selectedIndex = 0;
  static const _pageLabels = [
    'Inicio',
    'Mis Ofertas',
    'Postulantes',
    'Mi Perfil',
  ];

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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RequireRole(
      user: widget.user,
      allowedRoles: const [UserRoles.company],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.orange,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _pageLabels[_selectedIndex],
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: _handleLogout,
              tooltip: 'Cerrar Sesión',
            ),
          ],
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              activeIcon: Icon(Icons.work),
              label: 'Mis Ofertas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Postulantes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Mi Perfil',
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
                    style: TextStyle(color: Colors.white70, fontSize: 14),
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Acciones rápidas
          _buildActionCard(
            icon: Icons.work_outline,
            title: 'Crear Oferta',
            description: 'Publica una nueva oferta de práctica',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OfferFormPage()),
            ),
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

  // ─── MIS OFERTAS ───────────────────────────────────────────
  Widget _buildOffersTab() {
    final companyId = widget.user.uid;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OfferFormPage()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nueva Oferta'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<List<OfertaModel>>(
        stream: _firestoreService.getOfertasByCompanyStream(companyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final ofertas = snapshot.data ?? [];
          if (ofertas.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_off, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text(
                    'No tienes ofertas publicadas',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Toca + para crear tu primera oferta',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: ofertas.length,
            itemBuilder: (context, i) {
              final oferta = ofertas[i];
              return _OfertaCard(
                oferta: oferta,
                firestoreService: _firestoreService,
                onEdit: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OfferFormPage(oferta: oferta),
                  ),
                ),
                onDelete: () => _confirmDeleteOferta(oferta),
                onVerPostulantes: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _PostulantesOfertaPage(oferta: oferta),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _confirmDeleteOferta(OfertaModel oferta) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar Oferta'),
        content: Text(
          '¿Eliminar "${oferta.titulo}"? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      try {
        await _firestoreService.deleteOferta(oferta.id);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Oferta eliminada')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }
  }

  // ─── POSTULANTES ───────────────────────────────────────────
  Widget _buildApplicantsTab() {
    final companyId = widget.user.uid;

    return StreamBuilder<List<OfertaModel>>(
      stream: _firestoreService.getOfertasByCompanyStream(companyId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final ofertas = snapshot.data ?? [];
        if (ofertas.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Crea ofertas para ver postulantes',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ofertas.length,
          itemBuilder: (context, i) {
            final oferta = ofertas[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(Icons.work_outline, color: Colors.orange),
                title: Text(
                  oferta.titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _estadoOfertaLabel(oferta.estado),
                  style: TextStyle(color: _estadoOfertaColor(oferta.estado)),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _PostulantesOfertaPage(oferta: oferta),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _estadoOfertaLabel(OfertaEstado estado) {
    switch (estado) {
      case OfertaEstado.publicada:
        return 'Publicada';
      case OfertaEstado.borrador:
        return 'Borrador';
      case OfertaEstado.cerrado:
        return 'Cerrada';
    }
  }

  Color _estadoOfertaColor(OfertaEstado estado) {
    switch (estado) {
      case OfertaEstado.publicada:
        return Colors.green;
      case OfertaEstado.borrador:
        return Colors.grey;
      case OfertaEstado.cerrado:
        return Colors.red;
    }
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
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
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
        title: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// ─── TARJETA DE OFERTA ────────────────────────────────────────────────────────
class _OfertaCard extends StatelessWidget {
  final OfertaModel oferta;
  final FirestoreService firestoreService;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onVerPostulantes;

  const _OfertaCard({
    required this.oferta,
    required this.firestoreService,
    required this.onEdit,
    required this.onDelete,
    required this.onVerPostulantes,
  });

  Color _estadoColor(OfertaEstado estado) {
    switch (estado) {
      case OfertaEstado.publicada:
        return Colors.green;
      case OfertaEstado.borrador:
        return Colors.grey;
      case OfertaEstado.cerrado:
        return Colors.red;
    }
  }

  String _estadoLabel(OfertaEstado estado) {
    switch (estado) {
      case OfertaEstado.publicada:
        return 'Publicada';
      case OfertaEstado.borrador:
        return 'Borrador';
      case OfertaEstado.cerrado:
        return 'Cerrada';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    oferta.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'editar') onEdit();
                    if (v == 'eliminar') onDelete();
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'editar', child: Text('Editar')),
                    PopupMenuItem(
                      value: 'eliminar',
                      child: Text(
                        'Eliminar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              oferta.descripcion,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _estadoColor(oferta.estado).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _estadoColor(oferta.estado).withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    _estadoLabel(oferta.estado),
                    style: TextStyle(
                      fontSize: 12,
                      color: _estadoColor(oferta.estado),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.people, size: 16, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text(
                  '${oferta.vacantes} vacante(s)',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onVerPostulantes,
                  icon: const Icon(Icons.people, size: 16),
                  label: const Text('Postulantes'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.orange,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── PÁGINA: POSTULANTES DE UNA OFERTA ───────────────────────────────────────
class _PostulantesOfertaPage extends StatelessWidget {
  final OfertaModel oferta;

  const _PostulantesOfertaPage({required this.oferta});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text(oferta.titulo, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<List<PostulacionModel>>(
        stream: firestoreService.getApplicationsByOfferStream(oferta.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final postulaciones = snapshot.data ?? [];
          if (postulaciones.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nadie se ha postulado aún',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: postulaciones.length,
            itemBuilder: (context, i) {
              final post = postulaciones[i];
              return _PostulanteCard(
                postulacion: post,
                firestoreService: firestoreService,
              );
            },
          );
        },
      ),
    );
  }
}

// ─── TARJETA DE POSTULANTE (empresa gestiona estado + seguimiento) ────────────
class _PostulanteCard extends StatelessWidget {
  final PostulacionModel postulacion;
  final FirestoreService firestoreService;

  const _PostulanteCard({
    required this.postulacion,
    required this.firestoreService,
  });

  Color _estadoColor(PostulacionEstado estado) {
    switch (estado) {
      case PostulacionEstado.postulado:
        return Colors.blue;
      case PostulacionEstado.preseleccionado:
        return Colors.orange;
      case PostulacionEstado.aprobado:
        return Colors.green;
      case PostulacionEstado.rechazado:
        return Colors.red;
    }
  }

  String _estadoLabel(PostulacionEstado estado) {
    switch (estado) {
      case PostulacionEstado.postulado:
        return 'Postulado';
      case PostulacionEstado.preseleccionado:
        return 'Preseleccionado';
      case PostulacionEstado.aprobado:
        return 'Aprobado';
      case PostulacionEstado.rechazado:
        return 'Rechazado';
    }
  }

  Future<void> _cambiarEstado(
    BuildContext context,
    PostulacionModel post,
  ) async {
    PostulacionEstado? nuevoEstado;
    String? motivo;

    nuevoEstado = await showDialog<PostulacionEstado>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Cambiar estado'),
        children: PostulacionEstado.values
            .map(
              (e) => SimpleDialogOption(
                onPressed: () => Navigator.pop(context, e),
                child: Text(_estadoLabel(e)),
              ),
            )
            .toList(),
      ),
    );

    if (nuevoEstado == null) return;

    if (nuevoEstado == PostulacionEstado.rechazado) {
      final controller = TextEditingController();
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Motivo de rechazo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Ingresa el motivo'),
            maxLines: 2,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      );
      if (confirmed != true || controller.text.trim().isEmpty) return;
      motivo = controller.text.trim();
    }

    try {
      await firestoreService.updateApplicationStatus(
        post.id,
        nuevoEstado,
        motivo: motivo,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Estado actualizado')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _estadoColor(postulacion.estado);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<UserModel?>(
              future: firestoreService.getUserById(postulacion.studentId),
              builder: (context, snap) {
                final user = snap.data;
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color.withOpacity(0.15),
                      child: Icon(Icons.person, color: color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? 'Estudiante',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user?.email ?? postulacion.studentId,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withOpacity(0.5)),
                  ),
                  child: Text(
                    _estadoLabel(postulacion.estado),
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _cambiarEstado(context, postulacion),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Estado'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.orange,
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 4),
                TextButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeguimientoListPage(
                        postulacionId: postulacion.id,
                        readOnly: false,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.track_changes, size: 16),
                  label: const Text('Seguimiento'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            if (postulacion.estado == PostulacionEstado.rechazado &&
                postulacion.motivoRechazo != null) ...[
              const SizedBox(height: 4),
              Text(
                'Motivo: ${postulacion.motivoRechazo}',
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
