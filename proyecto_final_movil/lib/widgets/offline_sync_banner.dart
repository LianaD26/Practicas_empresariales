import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/local/database.dart';
import '../services/connectivity_service.dart';

/// Barra global: modo sin conexión y operaciones pendientes de sincronizar.
class OfflineSyncBanner extends StatelessWidget {
  const OfflineSyncBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivity = context.read<ConnectivityService>();
    final db = context.read<AppDatabase>();

    return StreamBuilder<bool>(
      stream: connectivity.onConnectivityChanged,
      initialData: true,
      builder: (context, connectionSnapshot) {
        return StreamBuilder<int>(
          stream: db.pendingOperationsDao.watchPendingCount(),
          builder: (context, pendingSnapshot) {
            return FutureBuilder<bool>(
              future: connectivity.hasConnection,
              builder: (context, hasConnectionSnapshot) {
                final hasConnection =
                    connectionSnapshot.data ?? hasConnectionSnapshot.data ?? true;
                final pendingCount = pendingSnapshot.data ?? 0;

                if (hasConnection && pendingCount == 0) {
                  return const SizedBox.shrink();
                }

                final message = !hasConnection
                    ? (pendingCount > 0
                        ? 'Sin conexión · $pendingCount pendiente(s) de sincronización'
                        : 'Sin conexión · Los datos guardados se muestran desde el dispositivo')
                    : '$pendingCount registro(s) pendiente(s) de sincronización';

                return Material(
                  color: !hasConnection ? Colors.orange.shade800 : Colors.amber.shade800,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            !hasConnection ? Icons.cloud_off : Icons.sync,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              message,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
