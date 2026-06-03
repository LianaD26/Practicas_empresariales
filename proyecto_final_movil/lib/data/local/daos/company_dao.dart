import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/company_table.dart';

part 'company_dao.g.dart';

/// DAO para operaciones CRUD locales sobre empresas
@DriftAccessor(tables: [CompanyEntries])
class CompanyDao extends DatabaseAccessor<AppDatabase>
    with _$CompanyDaoMixin {
  CompanyDao(AppDatabase db) : super(db);

  /// Observa todas las empresas activas
  Stream<List<CompanyEntry>> watchActive() {
    return (select(companyEntries)
          ..where((t) => t.isActive.equals(true)))
        .watch();
  }

  /// Observa una empresa por ID
  Stream<CompanyEntry?> watchById(String id) {
    return (select(companyEntries)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Obtiene una empresa por ID
  Future<CompanyEntry?> getById(String id) {
    return (select(companyEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Inserta o actualiza una empresa
  Future<void> upsert(CompanyEntriesCompanion entry) {
    return into(companyEntries).insertOnConflictUpdate(entry);
  }

  /// Inserta o actualiza múltiples empresas en batch
  Future<void> upsertAll(List<CompanyEntriesCompanion> entries) {
    return batch(
        (b) => b.insertAllOnConflictUpdate(companyEntries, entries));
  }

  /// Elimina una empresa por ID
  Future<int> deleteById(String id) {
    return (delete(companyEntries)..where((t) => t.id.equals(id))).go();
  }

  /// Elimina todas las empresas locales
  Future<int> deleteAll() => delete(companyEntries).go();
}
