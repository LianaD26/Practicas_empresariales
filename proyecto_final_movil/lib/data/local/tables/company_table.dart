import 'package:drift/drift.dart';

/// Tabla local para empresas — replica campos de EmpresaModel
class CompanyEntries extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get ubicacion => text().nullable()();
  TextColumn get contacto => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
