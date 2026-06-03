import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/offer_model.dart';
import '../models/postulation_model.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'document_list_page.dart';
import 'follow-up_list_page.dart';

/// Página principal para estudiantes
/// Pueden ver ofertas, postularse y ver sus postulaciones
class StudentHomePage extends StatefulWidget {
  final UserModel user;

  const StudentHomePage({super.key, required this.user});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  int _selectedIndex = 0;
  OfertaModel? _selectedOffer;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    return Scaffold(
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
            _selectedOffer = null;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_special),
            label: 'Mis Postulaciones',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: Colors.deepPurple,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _selectedOffer != null
            ? _buildOfferDetailView()
            : _buildHomeTab();
      case 1:
        return _buildApplicationsTab();
      case 2:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  // ─── POSTULAR ──────────────────────────────────────────────
  Future<void> _handlePostular(OfertaModel offer) async {
    final studentId = _authService.currentUser?.uid ?? '';
    if (studentId.isEmpty) return;

    try {
      final alreadyApplied = await _firestoreService.hasStudentApplied(
        studentId,
        offer.id,
      );
      if (alreadyApplied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ya estás postulado a esta oferta')),
          );
        }
        return;
      }

      final docRef = FirebaseFirestore.instance
          .collection('applications')
          .doc();
      final postulacion = PostulacionModel(
        id: docRef.id,
        ofertaId: offer.id,
        studentId: studentId,
        createdAt: DateTime.now(),
      );
      await _firestoreService.createOrUpdatePostulacion(postulacion);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Postulación enviada exitosamente!')),
        );
        setState(() {
          _selectedOffer = null;
          _selectedIndex = 1;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al postularse: $e')));
      }
    }
  }

  // ─── INICIO (OFERTAS) ───────────────────────────────────────
  Widget _buildHomeTab() {
    return StreamBuilder<List<OfertaModel>>(
      stream: _firestoreService.getPublishedOffersStream(),
      builder: (context, snapshot) {
        final allOffers = snapshot.data ?? [];
        final filteredOffers = _searchQuery.isEmpty
            ? allOffers
            : allOffers.where((o) {
                final q = _searchQuery.toLowerCase();
                return o.titulo.toLowerCase().contains(q) ||
                    o.descripcion.toLowerCase().contains(q) ||
                    (o.ubicacion?.toLowerCase().contains(q) ?? false) ||
                    (o.areaPractica?.toLowerCase().contains(q) ?? false);
              }).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
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
              const Text(
                'Ofertas de Práctica',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Buscar por título, área o ubicación...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.deepPurple,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (snapshot.connectionState == ConnectionState.waiting &&
                  allOffers.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (filteredOffers.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'No se encontraron ofertas',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredOffers.length,
                  itemBuilder: (context, index) {
                    final offer = filteredOffers[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const Icon(
                          Icons.work_outline,
                          color: Colors.deepPurple,
                        ),
                        title: Text(
                          offer.titulo,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          [
                            if (offer.areaPractica != null) offer.areaPractica!,
                            if (offer.ubicacion != null) offer.ubicacion!,
                          ].join(' · '),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => setState(() => _selectedOffer = offer),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // ─── DETALLE DE OFERTA ──────────────────────────────────────
  Widget _buildOfferDetailView() {
    final offer = _selectedOffer!;
    final studentId = _authService.currentUser?.uid ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _selectedOffer = null),
            child: const Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  'Volver',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.titulo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildOfferInfo(
                    'Descripción',
                    offer.descripcion,
                    Icons.description,
                  ),
                  if (offer.ubicacion != null) ...[
                    const SizedBox(height: 12),
                    _buildOfferInfo(
                      'Ubicación',
                      offer.ubicacion!,
                      Icons.location_on,
                    ),
                  ],
                  if (offer.areaPractica != null) ...[
                    const SizedBox(height: 12),
                    _buildOfferInfo(
                      'Área',
                      offer.areaPractica!,
                      Icons.category,
                    ),
                  ],
                  if (offer.requisitos != null) ...[
                    const SizedBox(height: 12),
                    _buildOfferInfo(
                      'Requisitos',
                      offer.requisitos!,
                      Icons.checklist,
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildOfferInfo(
                    'Vacantes',
                    offer.vacantes.toString(),
                    Icons.people,
                  ),
                  const SizedBox(height: 12),
                  _buildOfferInfo(
                    'Fecha límite',
                    '${offer.fechaLimite.day.toString().padLeft(2, '0')}/'
                        '${offer.fechaLimite.month.toString().padLeft(2, '0')}/'
                        '${offer.fechaLimite.year}',
                    Icons.calendar_today,
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<bool>(
                    future: _firestoreService.hasStudentApplied(
                      studentId,
                      offer.id,
                    ),
                    builder: (context, snap) {
                      final alreadyApplied = snap.data ?? false;
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              alreadyApplied ||
                                  snap.connectionState ==
                                      ConnectionState.waiting
                              ? null
                              : () => _handlePostular(offer),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: Text(
                            alreadyApplied
                                ? '✓ Ya estás postulado'
                                : 'Postularme',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
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
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── MIS POSTULACIONES ──────────────────────────────────────
  Widget _buildApplicationsTab() {
    final studentId = _authService.currentUser?.uid ?? '';

    return StreamBuilder<List<PostulacionModel>>(
      stream: _firestoreService.getApplicationsByStudentStream(studentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final postulaciones = snapshot.data ?? [];

        if (postulaciones.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_open, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No tienes postulaciones aún',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Explora las ofertas y postúlate',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
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
            return _PostulacionCard(
              postulacion: post,
              firestoreService: _firestoreService,
              onVerSeguimiento: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SeguimientoListPage(
                    postulacionId: post.id,
                    readOnly: true,
                  ),
                ),
              ),
            );
          },
        );
      },
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
            value: 'Estudiante',
            icon: Icons.badge,
          ),
          const SizedBox(height: 12),

          _buildProfileCard(
            label: 'Estado',
            value: widget.user.status.toString().split('.').last,
            icon: Icons.info,
          ),
          const SizedBox(height: 24),

          const Text(
            'Mis Documentos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.description,
                color: Colors.deepPurple,
                size: 32,
              ),
              title: const Text(
                'Gestionar Documentos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Sube o edita tu Hoja de Vida y Carta de Presentación',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DocumentoListPage()),
              ),
            ),
          ),
        ],
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

// ─── WIDGET AUXILIAR: TARJETA DE POSTULACIÓN ────────────────────────────────
class _PostulacionCard extends StatelessWidget {
  final PostulacionModel postulacion;
  final FirestoreService firestoreService;
  final VoidCallback onVerSeguimiento;

  const _PostulacionCard({
    required this.postulacion,
    required this.firestoreService,
    required this.onVerSeguimiento,
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

  IconData _estadoIcon(PostulacionEstado estado) {
    switch (estado) {
      case PostulacionEstado.postulado:
        return Icons.hourglass_empty;
      case PostulacionEstado.preseleccionado:
        return Icons.star_half;
      case PostulacionEstado.aprobado:
        return Icons.check_circle;
      case PostulacionEstado.rechazado:
        return Icons.cancel;
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OfertaModel?>(
      future: firestoreService.getOfertaById(postulacion.ofertaId),
      builder: (context, snapshot) {
        final oferta = snapshot.data;
        final color = _estadoColor(postulacion.estado);
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.15),
                  child: Icon(_estadoIcon(postulacion.estado), color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        oferta?.titulo ?? 'Cargando...',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
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
                      if (postulacion.estado == PostulacionEstado.rechazado &&
                          postulacion.motivoRechazo != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Motivo: ${postulacion.motivoRechazo}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.track_changes,
                    color: Colors.deepPurple,
                  ),
                  tooltip: 'Ver seguimiento',
                  onPressed: onVerSeguimiento,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
