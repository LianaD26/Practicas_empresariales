// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_up_dao.dart';

// ignore_for_file: type=lint
mixin _$FollowUpDaoMixin on DatabaseAccessor<AppDatabase> {
  $FollowUpEntriesTable get followUpEntries => attachedDatabase.followUpEntries;
  FollowUpDaoManager get managers => FollowUpDaoManager(this);
}

class FollowUpDaoManager {
  final _$FollowUpDaoMixin _db;
  FollowUpDaoManager(this._db);
  $$FollowUpEntriesTableTableManager get followUpEntries =>
      $$FollowUpEntriesTableTableManager(
        _db.attachedDatabase,
        _db.followUpEntries,
      );
}
