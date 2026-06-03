import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/offer_table.dart';

part 'offer_dao.g.dart';

/// DAO para operaciones CRUD locales sobre ofertas
@DriftAccessor(tables: [OfferEntries])
class OfferDao extends DatabaseAccessor<AppDatabase> with _$OfferDaoMixin {
  OfferDao(AppDatabase db) : super(db);

  /// Observa todas las ofertas publicadas, ordenadas por fecha de creación
  Stream<List<OfferEntry>> watchPublished() {
    return (select(offerEntries)
          ..where((t) => t.estado.equals('publicada'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Observa ofertas de una empresa específica
  Stream<List<OfferEntry>> watchByCompany(String companyId) {
    return (select(offerEntries)
          ..where((t) => t.empresaId.equals(companyId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Obtiene una oferta por ID
  Future<OfferEntry?> getById(String id) {
    return (select(offerEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Observa una oferta por ID
  Stream<OfferEntry?> watchById(String id) {
    return (select(offerEntries)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Inserta o actualiza una oferta
  Future<void> upsert(OfferEntriesCompanion entry) {
    return into(offerEntries).insertOnConflictUpdate(entry);
  }

  /// Inserta o actualiza múltiples ofertas en batch
  Future<void> upsertAll(List<OfferEntriesCompanion> entries) {
    return batch((b) => b.insertAllOnConflictUpdate(offerEntries, entries));
  }

  /// Elimina una oferta por ID
  Future<int> deleteById(String id) {
    return (delete(offerEntries)..where((t) => t.id.equals(id))).go();
  }

  /// Elimina todas las ofertas locales
  Future<int> deleteAll() => delete(offerEntries).go();
}
