// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postulation_dao.dart';

// ignore_for_file: type=lint
mixin _$PostulationDaoMixin on DatabaseAccessor<AppDatabase> {
  $PostulationEntriesTable get postulationEntries =>
      attachedDatabase.postulationEntries;
  PostulationDaoManager get managers => PostulationDaoManager(this);
}

class PostulationDaoManager {
  final _$PostulationDaoMixin _db;
  PostulationDaoManager(this._db);
  $$PostulationEntriesTableTableManager get postulationEntries =>
      $$PostulationEntriesTableTableManager(
        _db.attachedDatabase,
        _db.postulationEntries,
      );
}
