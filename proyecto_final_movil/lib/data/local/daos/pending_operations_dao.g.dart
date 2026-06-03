// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_operations_dao.dart';

// ignore_for_file: type=lint
mixin _$PendingOperationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PendingOperationEntriesTable get pendingOperationEntries =>
      attachedDatabase.pendingOperationEntries;
  PendingOperationsDaoManager get managers => PendingOperationsDaoManager(this);
}

class PendingOperationsDaoManager {
  final _$PendingOperationsDaoMixin _db;
  PendingOperationsDaoManager(this._db);
  $$PendingOperationEntriesTableTableManager get pendingOperationEntries =>
      $$PendingOperationEntriesTableTableManager(
        _db.attachedDatabase,
        _db.pendingOperationEntries,
      );
}
