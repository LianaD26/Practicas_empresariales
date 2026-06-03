/// Tipos de operación para la cola de sincronización offline
enum OperationType {
  create('create'),
  update('update'),
  delete('delete');

  final String value;
  const OperationType(this.value);

  static OperationType fromValue(String value) {
    return OperationType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => OperationType.create,
    );
  }
}

/// Tipos de entidad que pueden ser sincronizadas
enum EntityType {
  user('user'),
  offer('offer'),
  postulation('postulation'),
  document('document'),
  followUp('follow_up'),
  company('company');

  final String value;
  const EntityType(this.value);

  static EntityType fromValue(String value) {
    return EntityType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EntityType.user,
    );
  }
}

/// Estado de sincronización de un registro local
enum SyncStatus {
  synced('synced'),
  pending('pending'),
  error('error');

  final String value;
  const SyncStatus(this.value);

  static SyncStatus fromValue(String value) {
    return SyncStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SyncStatus.synced,
    );
  }
}
