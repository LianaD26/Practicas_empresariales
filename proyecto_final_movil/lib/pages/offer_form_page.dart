import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/oferta_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

/// Formulario para crear o editar una oferta de práctica (uso exclusivo de empresa)
class OfferFormPage extends StatefulWidget {
  final OfertaModel? oferta;

  const OfferFormPage({super.key, this.oferta});

  @override
  State<OfferFormPage> createState() => _OfferFormPageState();
}

class _OfferFormPageState extends State<OfferFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _areaController = TextEditingController();
  final _requisitosController = TextEditingController();
  final _vacantesController = TextEditingController(text: '1');

  final _firestoreService = FirestoreService();
  final _authService = AuthService();

  OfertaEstado _estadoSeleccionado = OfertaEstado.publicada;
  DateTime _fechaLimite = DateTime.now().add(const Duration(days: 30));
  bool _isLoading = false;
  String? _errorMessage;

  bool get _isEditing => widget.oferta != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final o = widget.oferta!;
      _tituloController.text = o.titulo;
      _descripcionController.text = o.descripcion;
      _ubicacionController.text = o.ubicacion ?? '';
      _areaController.text = o.areaPractica ?? '';
      _requisitosController.text = o.requisitos ?? '';
      _vacantesController.text = o.vacantes.toString();
      _estadoSeleccionado = o.estado;
      _fechaLimite = o.fechaLimite;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _ubicacionController.dispose();
    _areaController.dispose();
    _requisitosController.dispose();
    _vacantesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaLimite.isAfter(DateTime.now())
          ? _fechaLimite
          : DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _fechaLimite = picked);
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final empresaId = _authService.currentUser?.uid ?? '';
      final now = DateTime.now();

      OfertaModel oferta;
      if (_isEditing) {
        oferta = OfertaModel(
          id: widget.oferta!.id,
          titulo: _tituloController.text.trim(),
          descripcion: _descripcionController.text.trim(),
          empresaId: widget.oferta!.empresaId,
          estado: _estadoSeleccionado,
          fechaLimite: _fechaLimite,
          vacantes: int.tryParse(_vacantesController.text) ?? 1,
          ubicacion: _ubicacionController.text.trim().isEmpty
              ? null
              : _ubicacionController.text.trim(),
          areaPractica: _areaController.text.trim().isEmpty
              ? null
              : _areaController.text.trim(),
          requisitos: _requisitosController.text.trim().isEmpty
              ? null
              : _requisitosController.text.trim(),
          createdAt: widget.oferta!.createdAt,
          updatedAt: now,
        );
      } else {
        final docRef = FirebaseFirestore.instance.collection('offers').doc();
        oferta = OfertaModel(
          id: docRef.id,
          titulo: _tituloController.text.trim(),
          descripcion: _descripcionController.text.trim(),
          empresaId: empresaId,
          estado: _estadoSeleccionado,
          fechaLimite: _fechaLimite,
          vacantes: int.tryParse(_vacantesController.text) ?? 1,
          ubicacion: _ubicacionController.text.trim().isEmpty
              ? null
              : _ubicacionController.text.trim(),
          areaPractica: _areaController.text.trim().isEmpty
              ? null
              : _areaController.text.trim(),
          requisitos: _requisitosController.text.trim().isEmpty
              ? null
              : _requisitosController.text.trim(),
          createdAt: now,
        );
      }

      await _firestoreService.createOrUpdateOferta(oferta);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing ? 'Oferta actualizada' : 'Oferta creada exitosamente',
            ),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Error: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Oferta' : 'Nueva Oferta'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.work, size: 64, color: Colors.orange),
              const SizedBox(height: 24),

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

              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título de la oferta *',
                  prefixIcon: Icon(Icons.title),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) => v == null || v.trim().length < 5
                    ? 'Mínimo 5 caracteres'
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción *',
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (v) => v == null || v.trim().length < 10
                    ? 'Mínimo 10 caracteres'
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _ubicacionController,
                decoration: const InputDecoration(
                  labelText: 'Ubicación',
                  prefixIcon: Icon(Icons.location_on),
                  hintText: 'Medellín, Colombia',
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(
                  labelText: 'Área de práctica',
                  prefixIcon: Icon(Icons.category),
                  hintText: 'Tecnología, Administración...',
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _requisitosController,
                decoration: const InputDecoration(
                  labelText: 'Requisitos',
                  prefixIcon: Icon(Icons.checklist),
                  alignLabelWithHint: true,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _vacantesController,
                decoration: const InputDecoration(
                  labelText: 'Vacantes *',
                  prefixIcon: Icon(Icons.people),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 1)
                    return 'Ingrese un número válido (mínimo 1)';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Fecha límite
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.calendar_today,
                    color: Colors.orange,
                  ),
                  title: const Text('Fecha límite'),
                  subtitle: Text(
                    '${_fechaLimite.day.toString().padLeft(2, '0')}/'
                    '${_fechaLimite.month.toString().padLeft(2, '0')}/'
                    '${_fechaLimite.year}',
                  ),
                  trailing: TextButton(
                    onPressed: _selectDate,
                    child: const Text('Cambiar'),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<OfertaEstado>(
                value: _estadoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: const [
                  DropdownMenuItem(
                    value: OfertaEstado.publicada,
                    child: Text('Publicada'),
                  ),
                  DropdownMenuItem(
                    value: OfertaEstado.borrador,
                    child: Text('Borrador'),
                  ),
                  DropdownMenuItem(
                    value: OfertaEstado.cerrado,
                    child: Text('Cerrada'),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _estadoSeleccionado = v);
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        _isEditing ? 'Actualizar Oferta' : 'Publicar Oferta',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
