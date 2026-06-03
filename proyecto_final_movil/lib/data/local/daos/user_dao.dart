import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/user_table.dart';

part 'user_dao.g.dart';

/// DAO para operaciones CRUD locales sobre usuarios
@DriftAccessor(tables: [UserEntries])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(AppDatabase db) : super(db);

  /// Observa todos los usuarios locales
  Stream<List<UserEntry>> watchAll() => select(userEntries).watch();

  /// Observa un usuario específico por UID
  Stream<UserEntry?> watchById(String uid) {
    return (select(userEntries)..where((t) => t.uid.equals(uid)))
        .watchSingleOrNull();
  }

  /// Obtiene un usuario por UID
  Future<UserEntry?> getById(String uid) {
    return (select(userEntries)..where((t) => t.uid.equals(uid)))
        .getSingleOrNull();
  }

  /// Obtiene usuarios filtrados por rol
  Stream<List<UserEntry>> watchByRole(String role) {
    return (select(userEntries)..where((t) => t.role.equals(role))).watch();
  }

  /// Inserta o actualiza un usuario
  Future<void> upsert(UserEntriesCompanion entry) {
    return into(userEntries).insertOnConflictUpdate(entry);
  }

  /// Inserta o actualiza múltiples usuarios en batch
  Future<void> upsertAll(List<UserEntriesCompanion> entries) {
    return batch((b) => b.insertAllOnConflictUpdate(userEntries, entries));
  }

  /// Elimina un usuario por UID
  Future<int> deleteById(String uid) {
    return (delete(userEntries)..where((t) => t.uid.equals(uid))).go();
  }

  /// Elimina todos los usuarios locales
  Future<int> deleteAll() => delete(userEntries).go();
}
