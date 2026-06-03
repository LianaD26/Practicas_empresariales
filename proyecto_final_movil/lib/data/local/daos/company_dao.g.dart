// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_dao.dart';

// ignore_for_file: type=lint
mixin _$CompanyDaoMixin on DatabaseAccessor<AppDatabase> {
  $CompanyEntriesTable get companyEntries => attachedDatabase.companyEntries;
  CompanyDaoManager get managers => CompanyDaoManager(this);
}

class CompanyDaoManager {
  final _$CompanyDaoMixin _db;
  CompanyDaoManager(this._db);
  $$CompanyEntriesTableTableManager get companyEntries =>
      $$CompanyEntriesTableTableManager(
        _db.attachedDatabase,
        _db.companyEntries,
      );
}
