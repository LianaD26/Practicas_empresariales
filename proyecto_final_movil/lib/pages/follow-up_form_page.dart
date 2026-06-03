import 'package:flutter/material.dart';
import '../models/seguimiento_model.dart';
import '../services/follow-up_service.dart';
import '../validators/follow-up_validators.dart';

class SeguimientoFormPage extends StatefulWidget {
  final String postulacionId;
  /// Si se pasa un seguimiento existente, se usará para edición
  final SeguimientoModel? seguimiento;

  const SeguimientoFormPage({
    super.key,
    required this.postulacionId,
    this.seguimiento,
  });

  @override
  State<SeguimientoFormPage> createState() => _SeguimientoFormPageState();
}

class _SeguimientoFormPageState extends State<SeguimientoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _comentarioController = TextEditingController();
  final _seguimientoService = SeguimientoService();

  EstadoSeguimiento _estadoSeleccionado = EstadoSeguimiento.pendiente;
  bool _isLoading = false;
  String? _errorMessage;

  bool get _isEditing => widget.seguimiento != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _comentarioController.text = widget.seguimiento!.comentario;
      _estadoSeleccionado = widget.seguimiento!.estado;
    }
  }

  @override
  void dispose() {
    _comentarioController.dispose();
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
        final actualizado = widget.seguimiento!.copyWith(
          comentario: _comentarioController.text.trim(),
          estado: _estadoSeleccionado,
        );
        await _seguimientoService.actualizarSeguimiento(actualizado);
      } else {
        await _seguimientoService.crearSeguimiento(
          comentario: _comentarioController.text.trim(),
          estado: _estadoSeleccionado,
          postulacionId: widget.postulacionId,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Seguimiento actualizado correctamente'
                : 'Seguimiento creado correctamente'),
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
        title: Text(_isEditing ? 'Editar Seguimiento' : 'Nuevo Seguimiento'),
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
              const Icon(Icons.track_changes, size: 64, color: Colors.deepPurple),
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

              // Comentario
              TextFormField(
                controller: _comentarioController,
                decoration: const InputDecoration(
                  labelText: 'Comentario',
                  hintText: 'Describe el estado actual de la postulación...',
                  prefixIcon: Icon(Icons.comment_outlined),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                maxLength: 500,
                validator: SeguimientoValidators.validateComentario,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),

              // Estado
              DropdownButtonFormField<EstadoSeguimiento>(
                initialValue: _estadoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                items: EstadoSeguimiento.values
                    .map((estado) => DropdownMenuItem(
                          value: estado,
                          child: Text(estado.label),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _estadoSeleccionado = value);
                  }
                },
                validator: (_) =>
                    SeguimientoValidators.validateEstado(_estadoSeleccionado),
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
                        _isEditing ? 'Actualizar' : 'Guardar Seguimiento',
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
