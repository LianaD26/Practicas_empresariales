// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_dao.dart';

// ignore_for_file: type=lint
mixin _$DocumentDaoMixin on DatabaseAccessor<AppDatabase> {
  $DocumentEntriesTable get documentEntries => attachedDatabase.documentEntries;
  DocumentDaoManager get managers => DocumentDaoManager(this);
}

class DocumentDaoManager {
  final _$DocumentDaoMixin _db;
  DocumentDaoManager(this._db);
  $$DocumentEntriesTableTableManager get documentEntries =>
      $$DocumentEntriesTableTableManager(
        _db.attachedDatabase,
        _db.documentEntries,
      );
}
