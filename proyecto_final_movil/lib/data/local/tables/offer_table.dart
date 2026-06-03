import 'package:drift/drift.dart';

/// Tabla local para ofertas de práctica — replica campos de OfertaModel
class OfferEntries extends Table {
  TextColumn get id => text()();
  TextColumn get titulo => text()();
  TextColumn get descripcion => text()();
  TextColumn get empresaId => text()();
  TextColumn get estado => text().withDefault(const Constant('borrador'))();
  DateTimeColumn get fechaLimite => dateTime()();
  IntColumn get vacantes => integer().withDefault(const Constant(1))();
  TextColumn get ubicacion => text().nullable()();
  TextColumn get areaPractica => text().nullable()();
  TextColumn get requisitos => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
