import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();

  factory ConnectivityService() {
    return _instance;
  }

  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();

  /// Escucha los cambios en la conectividad a internet.
  /// Emite el estado actual al suscribirse y luego cada cambio.
  Stream<bool> get onConnectivityChanged async* {
    yield await hasConnection;
    yield* _connectivity.onConnectivityChanged.map(
      (results) => results.any((r) => r != ConnectivityResult.none),
    );
  }

  /// Verifica de manera asíncrona si hay conexión a internet activa en el momento.
  Future<bool> get hasConnection async {
    final results = await _connectivity.checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }
}
