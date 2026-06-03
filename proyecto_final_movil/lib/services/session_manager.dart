import 'dart:async';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  Timer? _timer;

  static const Duration timeout = Duration(seconds: 60);

  void startSessionTimer(BuildContext context) {
    _timer?.cancel();

    _timer = Timer(timeout, () async {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La sesión ha expirado por inactividad'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      await Future.delayed(const Duration(seconds: 2));

      await AuthService().signOut();
    });
  }

  void resetTimer(BuildContext context) {
    startSessionTimer(context);
  }

  void stopTimer() {
    _timer?.cancel();
  }
}