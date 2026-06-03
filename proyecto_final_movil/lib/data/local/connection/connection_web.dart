import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: 'practicas_empresariales',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    
    if (db.missingFeatures.isNotEmpty) {
      print('Using ${db.chosenImplementation} due to missing features: ${db.missingFeatures}');
    }
    
    return db.resolvedExecutor;
  }));
}
