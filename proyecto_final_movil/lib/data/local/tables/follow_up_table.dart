import 'package:drift/drift.dart';

/// Tabla local para seguimientos — replica campos de SeguimientoModel
class FollowUpEntries extends Table {
  TextColumn get id => text()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get comentario => text()();
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
  TextColumn get postulacionId => text()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
