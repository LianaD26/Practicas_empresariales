import 'package:flutter/material.dart';
import '../models/documento_model.dart';
import '../services/documento_service.dart';
import '../services/auth_service.dart';
import '../validators/documento_validators.dart';

class DocumentoFormPage extends StatefulWidget {
  /// Si se pasa un documento existente, se usará para edición
  final DocumentoModel? documento;

  /// Tipos que el usuario ya tiene subidos (para restringir duplicados al crear)
  final Set<TipoDocumento> tiposExistentes;

  const DocumentoFormPage({
    super.key,
    this.documento,
    this.tiposExistentes = const {},
  });

  @override
  State<DocumentoFormPage> createState() => _DocumentoFormPageState();
}

class _DocumentoFormPageState extends State<DocumentoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _urlController = TextEditingController();
  final _documentoService = DocumentoService();
  final _authService = AuthService();

  late TipoDocumento _tipoSeleccionado;
  bool _isLoading = false;
  String? _errorMessage;

  bool get _isEditing => widget.documento != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nombreController.text = widget.documento!.nombre;
      _urlController.text = widget.documento!.url;
      _tipoSeleccionado = widget.documento!.tipo;
    } else {
      final disponibles = TipoDocumento.values
          .where((t) => !widget.tiposExistentes.contains(t))
          .toList();
      _tipoSeleccionado = disponibles.isNotEmpty
          ? disponibles.first
          : TipoDocumento.hojaDeVida;
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
        final actualizado = widget.documento!.copyWith(
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
            content: Text(
              _isEditing
                  ? 'Documento actualizado correctamente'
                  : 'Documento creado correctamente',
            ),
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
                value: _tipoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Tipo de documento',
                  prefixIcon: Icon(Icons.category),
                ),
                items: TipoDocumento.values
                    .where(
                      (tipo) =>
                          _isEditing || !widget.tiposExistentes.contains(tipo),
                    )
                    .map(
                      (tipo) => DropdownMenuItem(
                        value: tipo,
                        child: Text(tipo.label),
                      ),
                    )
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
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: 'URL del documento',
                  hintText: 'https://drive.google.com/...',
                  prefixIcon: const Icon(Icons.link),
                  suffixIcon: _urlController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          tooltip: 'Limpiar',
                          onPressed: () {
                            _urlController.clear();
                            setState(() {});
                          },
                        )
                      : null,
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
