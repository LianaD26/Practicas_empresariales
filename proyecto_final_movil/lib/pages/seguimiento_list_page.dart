import 'package:flutter/material.dart';
import '../models/seguimiento_model.dart';
import '../services/seguimiento_service.dart';
import 'seguimiento_form_page.dart';

class SeguimientoListPage extends StatelessWidget {
  final String postulacionId;

  const SeguimientoListPage({super.key, required this.postulacionId});

  @override
  Widget build(BuildContext context) {
    final seguimientoService = SeguimientoService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimientos'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SeguimientoFormPage(postulacionId: postulacionId),
          ),
        ),
        tooltip: 'Agregar seguimiento',
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<SeguimientoModel>>(
        stream: seguimientoService
            .getSeguimientosPorPostulacionStream(postulacionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final seguimientos = snapshot.data ?? [];

          if (seguimientos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.track_changes_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay seguimientos aún',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Toca el botón + para agregar uno',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: seguimientos.length,
            itemBuilder: (context, index) {
              final seg = seguimientos[index];
              return _SeguimientoCard(
                seguimiento: seg,
                onEdit: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeguimientoFormPage(
                      postulacionId: postulacionId,
                      seguimiento: seg,
                    ),
                  ),
                ),
                onDelete: () =>
                    _confirmDelete(context, seg, seguimientoService),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    SeguimientoModel seg,
    SeguimientoService service,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Seguimiento'),
        content: const Text('¿Estás seguro de eliminar este seguimiento?'),
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
        await service.eliminarSeguimiento(seg.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Seguimiento eliminado')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }
}

class _SeguimientoCard extends StatelessWidget {
  final SeguimientoModel seguimiento;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _SeguimientoCard({
    required this.seguimiento,
    required this.onEdit,
    required this.onDelete,
  });

  Color _colorEstado(EstadoSeguimiento estado) {
    switch (estado) {
      case EstadoSeguimiento.aprobado:
        return Colors.green;
      case EstadoSeguimiento.rechazado:
        return Colors.red;
      case EstadoSeguimiento.enProceso:
        return Colors.orange;
      case EstadoSeguimiento.pendiente:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: _colorEstado(seguimiento.estado).withOpacity(0.1),
          child: Icon(
            Icons.track_changes,
            color: _colorEstado(seguimiento.estado),
          ),
        ),
        title: Text(
          seguimiento.comentario,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _colorEstado(seguimiento.estado).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _colorEstado(seguimiento.estado).withOpacity(0.5),
                ),
              ),
              child: Text(
                seguimiento.estado.label,
                style: TextStyle(
                  fontSize: 12,
                  color: _colorEstado(seguimiento.estado),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatFecha(seguimiento.fecha),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'editar') onEdit();
            if (value == 'eliminar') onDelete();
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'editar', child: Text('Editar')),
            PopupMenuItem(
              value: 'eliminar',
              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatFecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/'
        '${fecha.month.toString().padLeft(2, '0')}/'
        '${fecha.year}';
  }
}
