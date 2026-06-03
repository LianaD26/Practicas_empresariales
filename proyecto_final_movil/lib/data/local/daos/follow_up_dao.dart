import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/follow_up_table.dart';

part 'follow_up_dao.g.dart';

/// DAO para operaciones CRUD locales sobre seguimientos
@DriftAccessor(tables: [FollowUpEntries])
class FollowUpDao extends DatabaseAccessor<AppDatabase>
    with _$FollowUpDaoMixin {
  FollowUpDao(AppDatabase db) : super(db);

  /// Observa seguimientos de una postulación, ordenados por fecha
  Stream<List<FollowUpEntry>> watchByPostulation(String postulacionId) {
    return (select(followUpEntries)
          ..where((t) => t.postulacionId.equals(postulacionId))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .watch();
  }

  /// Observa seguimientos filtrados por estado
  Stream<List<FollowUpEntry>> watchByPostulationAndStatus(
      String postulacionId, String estado) {
    return (select(followUpEntries)
          ..where((t) =>
              t.postulacionId.equals(postulacionId) &
              t.estado.equals(estado))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .watch();
  }

  /// Obtiene un seguimiento por ID
  Future<FollowUpEntry?> getById(String id) {
    return (select(followUpEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Inserta o actualiza un seguimiento
  Future<void> upsert(FollowUpEntriesCompanion entry) {
    return into(followUpEntries).insertOnConflictUpdate(entry);
  }

  /// Inserta o actualiza múltiples seguimientos en batch
  Future<void> upsertAll(List<FollowUpEntriesCompanion> entries) {
    return batch(
        (b) => b.insertAllOnConflictUpdate(followUpEntries, entries));
  }

  /// Elimina un seguimiento por ID
  Future<int> deleteById(String id) {
    return (delete(followUpEntries)..where((t) => t.id.equals(id))).go();
  }

  /// Elimina todos los seguimientos locales
  Future<int> deleteAll() => delete(followUpEntries).go();
}
