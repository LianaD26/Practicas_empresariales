import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/user_model.dart';
import '../pages/blocked_page.dart';
import '../pages/pending_approval_page.dart';

/// Wrapper para proteger páginas internas según rol y estado de cuenta.
///
/// Si el usuario está bloqueado o pendiente, redirige a la pantalla
/// correspondiente. Si el rol no está permitido, muestra una alerta de
/// acceso denegado.
class RequireRole extends StatelessWidget {
  final UserModel user;
  final List<String> allowedRoles;
  final Widget child;
  final String? deniedMessage;

  const RequireRole({
    super.key,
    required this.user,
    required this.allowedRoles,
    required this.child,
    this.deniedMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (user.isBlocked) {
      return BlockedPage();
    }

    if (user.isPendingApproval) {
      return PendingApprovalPage(user: user);
    }

    if (!user.isActive) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Acceso denegado'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              deniedMessage ??
                  'Tu cuenta no está activa. Contacta con el administrador para continuar.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    if (!allowedRoles.contains(user.role)) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Acceso denegado'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              deniedMessage ?? AppMessages.errorAccessDenied,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return child;
  }
}
