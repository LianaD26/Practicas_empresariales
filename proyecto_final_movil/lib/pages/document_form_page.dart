import 'package:flutter/material.dart';
import '../models/document_model.dart';
import '../services/document_service.dart';
import '../services/auth_service.dart';
import '../validators/document_validators.dart';

class DocumentFormPage extends StatefulWidget {
  /// Si se pasa un documento existente, se usará para edición
  final DocumentModel? document;
  
  /// Conjunto de tipos de documentos que ya existen
  final Set<TipoDocumento> tiposExistentes;

  const DocumentFormPage({
    super.key,
    this.document,
    this.tiposExistentes = const {},
  });

  @override
  State<DocumentFormPage> createState() => _DocumentFormPageState();
}

class _DocumentFormPageState extends State<DocumentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _urlController = TextEditingController();
  final _documentoService = DocumentService();
  final _authService = AuthService();

  TipoDocumento _tipoSeleccionado = TipoDocumento.hojaDeVida;
  bool _isLoading = false;
  String? _errorMessage;

  bool get _isEditing => widget.document != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nombreController.text = widget.document!.nombre;
      _urlController.text = widget.document!.url;
      _tipoSeleccionado = widget.document!.tipo;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_isEditing) {
        final actualizado = widget.document!.copyWith(
          nombre: _nombreController.text.trim(),
          tipo: _tipoSeleccionado,
          url: _urlController.text.trim(),
        );
        await _documentoService.actualizarDocumento(actualizado);
      } else {
        final usuarioId = _authService.currentUser?.uid ?? '';
        await _documentoService.crearDocumento(
          nombre: _nombreController.text.trim(),
          tipo: _tipoSeleccionado,
          url: _urlController.text.trim(),
          usuarioId: usuarioId,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Documento actualizado correctamente'
                : 'Documento creado correctamente'),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Documento' : 'Nuevo Documento'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.description, size: 64, color: Colors.deepPurple),
              const SizedBox(height: 24),

              // Mensaje de error
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade800),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Nombre del documento
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del documento',
                  hintText: 'Ej: Mi Hoja de Vida 2024',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: DocumentoValidators.validateNombre,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),

              // Tipo de documento
              DropdownButtonFormField<TipoDocumento>(
                initialValue: _tipoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Tipo de documento',
                  prefixIcon: Icon(Icons.category),
                ),
                items: TipoDocumento.values
                    .where((tipo) =>
                        !widget.tiposExistentes.contains(tipo) ||
                        (_isEditing &&
                            widget.document!.tipo == tipo))
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo.label),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _tipoSeleccionado = value);
                  }
                },
                validator: (_) =>
                    DocumentoValidators.validateTipo(_tipoSeleccionado),
              ),
              const SizedBox(height: 16),

              // URL del documento
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'URL del documento',
                  hintText: 'https://drive.google.com/...',
                  prefixIcon: Icon(Icons.link),
                ),
                validator: DocumentoValidators.validateUrl,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 32),

              // Botón de guardar
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        _isEditing ? 'Actualizar' : 'Guardar Documento',
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
