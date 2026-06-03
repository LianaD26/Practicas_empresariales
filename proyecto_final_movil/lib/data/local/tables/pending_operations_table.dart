import 'package:drift/drift.dart';

/// Cola de operaciones pendientes de sincronización.
/// Implementa el patrón Transactional Outbox: las escrituras offline
/// se encolan aquí y se procesan cuando vuelve la conexión.
class PendingOperationEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operationType => text()(); // 'create', 'update', 'delete'
  TextColumn get entityType => text()();    // 'user', 'offer', 'postulation', etc.
  TextColumn get entityId => text()();      // ID de la entidad afectada
  TextColumn get payload => text()();       // JSON serializado de la entidad
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}
