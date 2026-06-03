import 'package:drift/drift.dart';

// Importación condicional: web en Chrome, native en móvil/escritorio
import 'connection/connection.dart';

// Tablas
import 'tables/user_table.dart';
import 'tables/offer_table.dart';
import 'tables/postulation_table.dart';
import 'tables/document_table.dart';
import 'tables/follow_up_table.dart';
import 'tables/company_table.dart';
import 'tables/pending_operations_table.dart';

// DAOs
import 'daos/user_dao.dart';
import 'daos/offer_dao.dart';
import 'daos/postulation_dao.dart';
import 'daos/document_dao.dart';
import 'daos/follow_up_dao.dart';
import 'daos/company_dao.dart';
import 'daos/pending_operations_dao.dart';

part 'database.g.dart';

/// Base de datos local principal de la aplicación.
/// Contiene todas las tablas para caché offline y la cola de sincronización.
/// Funciona en web (IndexedDB / OPFS via WASM) y en nativo (SQLite).
@DriftDatabase(
  tables: [
    UserEntries,
    OfferEntries,
    PostulationEntries,
    DocumentEntries,
    FollowUpEntries,
    CompanyEntries,
    PendingOperationEntries,
  ],
  daos: [
    UserDao,
    OfferDao,
    PostulationDao,
    DocumentDao,
    FollowUpDao,
    CompanyDao,
    PendingOperationsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Constructor normal: resuelve la conexión según la plataforma (web / nativo).
  AppDatabase() : super(connect());

  /// Constructor para testing con conexión inyectada.
  AppDatabase.forTesting(super.connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migraciones futuras irán aquí
      },
    );
  }
}

