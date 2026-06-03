import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/pending_operations_table.dart';

part 'pending_operations_dao.g.dart';

/// DAO para la cola de operaciones pendientes de sincronización.
/// Gestiona el ciclo de vida: enqueue → process → markSynced.
@DriftAccessor(tables: [PendingOperationEntries])
class PendingOperationsDao extends DatabaseAccessor<AppDatabase>
    with _$PendingOperationsDaoMixin {
  PendingOperationsDao(AppDatabase db) : super(db);

  /// Encola una nueva operación pendiente
  Future<int> enqueue({
    required String operationType,
    required String entityType,
    required String entityId,
    required String payload,
  }) {
    return into(pendingOperationEntries).insert(
      PendingOperationEntriesCompanion.insert(
        operationType: operationType,
        entityType: entityType,
        entityId: entityId,
        payload: payload,
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Obtiene todas las operaciones NO sincronizadas, ordenadas por creación
  Future<List<PendingOperationEntry>> getUnsynced() {
    return (select(pendingOperationEntries)
          ..where((t) => t.synced.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  /// Observa el conteo de operaciones pendientes (para mostrar badge en UI)
  Stream<int> watchPendingCount() {
    final countExp = pendingOperationEntries.id.count();
    final query = selectOnly(pendingOperationEntries)
      ..where(pendingOperationEntries.synced.equals(false))
      ..addColumns([countExp]);
    return query.watchSingle().map((row) => row.read(countExp) ?? 0);
  }

  /// Marca una operación como sincronizada
  Future<void> markSynced(int id) {
    return (update(pendingOperationEntries)
          ..where((t) => t.id.equals(id)))
        .write(const PendingOperationEntriesCompanion(
      synced: Value(true),
    ));
  }

  /// Incrementa el contador de reintentos
  Future<void> incrementRetry(int id) async {
    final entry = await (select(pendingOperationEntries)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (entry != null) {
      await (update(pendingOperationEntries)
            ..where((t) => t.id.equals(id)))
          .write(PendingOperationEntriesCompanion(
        retryCount: Value(entry.retryCount + 1),
      ));
    }
  }

  /// Elimina operaciones ya sincronizadas (limpieza)
  Future<int> deleteSynced() {
    return (delete(pendingOperationEntries)
          ..where((t) => t.synced.equals(true)))
        .go();
  }

  /// Elimina todas las operaciones pendientes
  Future<int> deleteAll() => delete(pendingOperationEntries).go();
}
