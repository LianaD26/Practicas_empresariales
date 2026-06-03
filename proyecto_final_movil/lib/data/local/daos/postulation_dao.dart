import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/postulation_table.dart';

part 'postulation_dao.g.dart';

/// DAO para operaciones CRUD locales sobre postulaciones
@DriftAccessor(tables: [PostulationEntries])
class PostulationDao extends DatabaseAccessor<AppDatabase>
    with _$PostulationDaoMixin {
  PostulationDao(AppDatabase db) : super(db);

  /// Observa postulaciones de un estudiante
  Stream<List<PostulationEntry>> watchByStudent(String studentId) {
    return (select(postulationEntries)
          ..where((t) => t.studentId.equals(studentId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Observa postulaciones para una oferta
  Stream<List<PostulationEntry>> watchByOffer(String offerId) {
    return (select(postulationEntries)
          ..where((t) => t.ofertaId.equals(offerId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Observa todas las postulaciones (para coordinador)
  Stream<List<PostulationEntry>> watchAll() {
    return (select(postulationEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Obtiene una postulación por ID
  Future<PostulationEntry?> getById(String id) {
    return (select(postulationEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Verifica si un estudiante ya se postuló a una oferta (local)
  Future<bool> hasStudentApplied(String studentId, String offerId) async {
    final result = await (select(postulationEntries)
          ..where((t) =>
              t.studentId.equals(studentId) & t.ofertaId.equals(offerId)))
        .get();
    return result.isNotEmpty;
  }

  /// Obtiene postulaciones pendientes de sincronización
  Future<List<PostulationEntry>> getPendingSync() {
    return (select(postulationEntries)
          ..where((t) => t.syncStatus.isIn(['pendingSync', 'pending'])))
        .get();
  }

  /// Inserta o actualiza una postulación
  Future<void> upsert(PostulationEntriesCompanion entry) {
    return into(postulationEntries).insertOnConflictUpdate(entry);
  }

  /// Inserta o actualiza múltiples postulaciones en batch
  Future<void> upsertAll(List<PostulationEntriesCompanion> entries) {
    return batch(
        (b) => b.insertAllOnConflictUpdate(postulationEntries, entries));
  }

  /// Marca una postulación como sincronizada
  Future<void> markSynced(String id) {
    return (update(postulationEntries)..where((t) => t.id.equals(id))).write(
      PostulationEntriesCompanion(
        syncStatus: const Value('synced'),
        lastSyncedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Elimina una postulación por ID
  Future<int> deleteById(String id) {
    return (delete(postulationEntries)..where((t) => t.id.equals(id))).go();
  }

  /// Elimina todas las postulaciones locales
  Future<int> deleteAll() => delete(postulationEntries).go();
}
