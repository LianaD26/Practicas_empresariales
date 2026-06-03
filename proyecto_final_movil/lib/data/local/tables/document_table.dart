import 'package:drift/drift.dart';

/// Tabla local para documentos — replica campos de DocumentModel
class DocumentEntries extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text()();
  TextColumn get tipo => text()();
  TextColumn get url => text()();
  DateTimeColumn get fechaSubida => dateTime()();
  TextColumn get usuarioId => text()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
