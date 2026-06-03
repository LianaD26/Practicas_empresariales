import 'package:drift/drift.dart';

/// Tabla local para usuarios — replica los campos de UserModel
class UserEntries extends Table {
  TextColumn get uid => text()();
  TextColumn get email => text()();
  TextColumn get displayName => text()();
  TextColumn get role => text().withDefault(const Constant('student'))();
  TextColumn get status => text().withDefault(const Constant('pendingApproval'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {uid};
}
