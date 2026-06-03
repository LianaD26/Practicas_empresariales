import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/document_model.dart';
import '../repositories/document_repository.dart';
import '../services/auth_service.dart';
import 'document_form_page.dart';

class DocumentListPage extends StatelessWidget {
  const DocumentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final currentUser = authService.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('Usuario no autenticado')),
      );
    }

    return StreamBuilder<List<DocumentModel>>(
      stream: context.read<DocumentRepository>().watchDocumentosPorUsuario(currentUser.uid),
      builder: (context, snapshot) {
        final documentos = snapshot.data ?? [];
        final tiposExistentes = documentos.map((d) => d.tipo).toSet();
        final allTypesCovered = TipoDocumento.values.every(
          (t) => tiposExistentes.contains(t),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Mis Documentos'),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: allTypesCovered
              ? null
              : FloatingActionButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DocumentFormPage(tiposExistentes: tiposExistentes),
                    ),
                  ),
                  tooltip: 'Agregar documento',
                  child: const Icon(Icons.add),
                ),
          body: snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : snapshot.hasError
              ? Center(child: Text('Error: \${snapshot.error}'))
              : documentos.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No tienes documentos aún',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Toca el botón + para agregar uno',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: documentos.length,
                  itemBuilder: (context, index) {
                    final doc = documentos[index];
                    return _DocumentoCard(
                      documento: doc,
                      onEdit: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DocumentFormPage(
                            document: doc,
                            tiposExistentes: tiposExistentes,
                          ),
                        ),
                      ),
                      onDelete: () =>
                          _confirmDelete(context, doc),
                    );
                  },
                ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    DocumentModel doc,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Documento'),
        content: Text('¿Estás seguro de eliminar "${doc.nombre}"?'),
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
        await context.read<DocumentRepository>().eliminarDocumento(doc.id);
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Documento eliminado')));
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error al eliminar: $e')));
        }
      }
    }
  }
}

class _DocumentoCard extends StatelessWidget {
  final DocumentModel documento;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DocumentoCard({
    required this.documento,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final icon = documento.tipo == TipoDocumento.hojaDeVida
        ? Icons.person_outline
        : Icons.mail_outline;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple.shade50,
          child: Icon(icon, color: Colors.deepPurple),
        ),
        title: Text(
          documento.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(documento.tipo.label),
            Text(
              'Subido: ${_formatFecha(documento.fechaSubida)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: SelectableText(
                    documento.url,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.deepPurple,
                    ),
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16, color: Colors.grey),
                  tooltip: 'Copiar enlace',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: documento.url));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enlace copiado')),
                    );
                  },
                ),
              ],
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
