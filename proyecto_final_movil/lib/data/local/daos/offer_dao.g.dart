// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_dao.dart';

// ignore_for_file: type=lint
mixin _$OfferDaoMixin on DatabaseAccessor<AppDatabase> {
  $OfferEntriesTable get offerEntries => attachedDatabase.offerEntries;
  OfferDaoManager get managers => OfferDaoManager(this);
}

class OfferDaoManager {
  final _$OfferDaoMixin _db;
  OfferDaoManager(this._db);
  $$OfferEntriesTableTableManager get offerEntries =>
      $$OfferEntriesTableTableManager(_db.attachedDatabase, _db.offerEntries);
}
