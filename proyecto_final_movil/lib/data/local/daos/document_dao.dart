import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/document_table.dart';

part 'document_dao.g.dart';

/// DAO para operaciones CRUD locales sobre documentos
@DriftAccessor(tables: [DocumentEntries])
class DocumentDao extends DatabaseAccessor<AppDatabase>
    with _$DocumentDaoMixin {
  DocumentDao(AppDatabase db) : super(db);

  /// Observa documentos de un usuario, ordenados por fecha de subida
  Stream<List<DocumentEntry>> watchByUser(String usuarioId) {
    return (select(documentEntries)
          ..where((t) => t.usuarioId.equals(usuarioId))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaSubida)]))
        .watch();
  }

  /// Observa documentos de un usuario filtrados por tipo
  Stream<List<DocumentEntry>> watchByUserAndType(
      String usuarioId, String tipo) {
    return (select(documentEntries)
          ..where(
              (t) => t.usuarioId.equals(usuarioId) & t.tipo.equals(tipo))
          ..orderBy([(t) => OrderingTerm.desc(t.fechaSubida)]))
        .watch();
  }

  /// Obtiene un documento por ID
  Future<DocumentEntry?> getById(String id) {
    return (select(documentEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Inserta o actualiza un documento
  Future<void> upsert(DocumentEntriesCompanion entry) {
    return into(documentEntries).insertOnConflictUpdate(entry);
  }

  /// Inserta o actualiza múltiples documentos en batch
  Future<void> upsertAll(List<DocumentEntriesCompanion> entries) {
    return batch(
        (b) => b.insertAllOnConflictUpdate(documentEntries, entries));
  }

  /// Elimina un documento por ID
  Future<int> deleteById(String id) {
    return (delete(documentEntries)..where((t) => t.id.equals(id))).go();
  }

  /// Elimina todos los documentos locales
  Future<int> deleteAll() => delete(documentEntries).go();
}
