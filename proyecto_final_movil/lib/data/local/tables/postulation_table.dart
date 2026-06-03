import 'package:drift/drift.dart';

/// Tabla local para postulaciones — replica campos de PostulacionModel
class PostulationEntries extends Table {
  TextColumn get id => text()();
  TextColumn get ofertaId => text()();
  TextColumn get studentId => text()();
  TextColumn get estado => text().withDefault(const Constant('postulado'))();
  TextColumn get motivoRechazo => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
