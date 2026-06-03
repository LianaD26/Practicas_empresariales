import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:proyecto_final_movil/data/local/database.dart';
import 'package:drift/drift.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
  });

  tearDown(() async {
    await db.close();
  });

  test('Database enqueues and processes pending operations', () async {
    // 1. Insert a pending operation
    final opId = await db.pendingOperationsDao.enqueue(
      operationType: 'create',
      entityType: 'offer',
      entityId: 'off-1',
      payload: '{"title": "Test Offer"}',
    );

    // 2. Verify it is retrieved as unsynced
    final unsynced = await db.pendingOperationsDao.getUnsynced();
    expect(unsynced.length, 1);
    expect(unsynced.first.id, opId);
    expect(unsynced.first.operationType, 'create');
    expect(unsynced.first.entityType, 'offer');
    expect(unsynced.first.entityId, 'off-1');
    expect(unsynced.first.payload, '{"title": "Test Offer"}');
    expect(unsynced.first.synced, false);

    // 3. Mark it synced
    await db.pendingOperationsDao.markSynced(opId);

    // 4. Verify unsynced list is empty
    final unsyncedAfter = await db.pendingOperationsDao.getUnsynced();
    expect(unsyncedAfter.isEmpty, true);

    // 5. Delete synced and verify database is clean
    final deleted = await db.pendingOperationsDao.deleteSynced();
    expect(deleted, 1);
  });

  test('Database inserts and watches published offers', () async {
    final now = DateTime.now();
    
    // Insert published offer
    await db.offerDao.upsert(OfferEntriesCompanion.insert(
      id: 'off-1',
      titulo: 'Oferta 1',
      descripcion: 'Descripción 1',
      empresaId: 'emp-1',
      estado: const Value('publicada'),
      fechaLimite: now.add(const Duration(days: 5)),
      createdAt: now,
    ));

    // Insert draft offer
    await db.offerDao.upsert(OfferEntriesCompanion.insert(
      id: 'off-2',
      titulo: 'Oferta 2',
      descripcion: 'Descripción 2',
      empresaId: 'emp-1',
      estado: const Value('borrador'),
      fechaLimite: now.add(const Duration(days: 5)),
      createdAt: now,
    ));

    final publishedOffers = await db.offerDao.watchPublished().first;
    expect(publishedOffers.length, 1);
    expect(publishedOffers.first.id, 'off-1');
    expect(publishedOffers.first.titulo, 'Oferta 1');
  });
}
