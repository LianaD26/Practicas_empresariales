// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dao.dart';

// ignore_for_file: type=lint
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserEntriesTable get userEntries => attachedDatabase.userEntries;
  UserDaoManager get managers => UserDaoManager(this);
}

class UserDaoManager {
  final _$UserDaoMixin _db;
  UserDaoManager(this._db);
  $$UserEntriesTableTableManager get userEntries =>
      $$UserEntriesTableTableManager(_db.attachedDatabase, _db.userEntries);
}
