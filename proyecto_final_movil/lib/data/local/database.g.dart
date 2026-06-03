// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserEntriesTable extends UserEntries
    with TableInfo<$UserEntriesTable, UserEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('student'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pendingApproval'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uid,
    email,
    displayName,
    role,
    status,
    createdAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  UserEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserEntry(
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $UserEntriesTable createAlias(String alias) {
    return $UserEntriesTable(attachedDatabase, alias);
  }
}

class UserEntry extends DataClass implements Insertable<UserEntry> {
  final String uid;
  final String email;
  final String displayName;
  final String role;
  final String status;
  final DateTime createdAt;
  final DateTime? lastSyncedAt;
  const UserEntry({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    required this.status,
    required this.createdAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['email'] = Variable<String>(email);
    map['display_name'] = Variable<String>(displayName);
    map['role'] = Variable<String>(role);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  UserEntriesCompanion toCompanion(bool nullToAbsent) {
    return UserEntriesCompanion(
      uid: Value(uid),
      email: Value(email),
      displayName: Value(displayName),
      role: Value(role),
      status: Value(status),
      createdAt: Value(createdAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory UserEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserEntry(
      uid: serializer.fromJson<String>(json['uid']),
      email: serializer.fromJson<String>(json['email']),
      displayName: serializer.fromJson<String>(json['displayName']),
      role: serializer.fromJson<String>(json['role']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'email': serializer.toJson<String>(email),
      'displayName': serializer.toJson<String>(displayName),
      'role': serializer.toJson<String>(role),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  UserEntry copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? role,
    String? status,
    DateTime? createdAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => UserEntry(
    uid: uid ?? this.uid,
    email: email ?? this.email,
    displayName: displayName ?? this.displayName,
    role: role ?? this.role,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  UserEntry copyWithCompanion(UserEntriesCompanion data) {
    return UserEntry(
      uid: data.uid.present ? data.uid.value : this.uid,
      email: data.email.present ? data.email.value : this.email,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      role: data.role.present ? data.role.value : this.role,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserEntry(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uid,
    email,
    displayName,
    role,
    status,
    createdAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserEntry &&
          other.uid == this.uid &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.role == this.role &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class UserEntriesCompanion extends UpdateCompanion<UserEntry> {
  final Value<String> uid;
  final Value<String> email;
  final Value<String> displayName;
  final Value<String> role;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const UserEntriesCompanion({
    this.uid = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserEntriesCompanion.insert({
    required String uid,
    required String email,
    required String displayName,
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uid = Value(uid),
       email = Value(email),
       displayName = Value(displayName),
       createdAt = Value(createdAt);
  static Insertable<UserEntry> custom({
    Expression<String>? uid,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<String>? role,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserEntriesCompanion copyWith({
    Value<String>? uid,
    Value<String>? email,
    Value<String>? displayName,
    Value<String>? role,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return UserEntriesCompanion(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserEntriesCompanion(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OfferEntriesTable extends OfferEntries
    with TableInfo<$OfferEntriesTable, OfferEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfferEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _empresaIdMeta = const VerificationMeta(
    'empresaId',
  );
  @override
  late final GeneratedColumn<String> empresaId = GeneratedColumn<String>(
    'empresa_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('borrador'),
  );
  static const VerificationMeta _fechaLimiteMeta = const VerificationMeta(
    'fechaLimite',
  );
  @override
  late final GeneratedColumn<DateTime> fechaLimite = GeneratedColumn<DateTime>(
    'fecha_limite',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vacantesMeta = const VerificationMeta(
    'vacantes',
  );
  @override
  late final GeneratedColumn<int> vacantes = GeneratedColumn<int>(
    'vacantes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _ubicacionMeta = const VerificationMeta(
    'ubicacion',
  );
  @override
  late final GeneratedColumn<String> ubicacion = GeneratedColumn<String>(
    'ubicacion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _areaPracticaMeta = const VerificationMeta(
    'areaPractica',
  );
  @override
  late final GeneratedColumn<String> areaPractica = GeneratedColumn<String>(
    'area_practica',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requisitosMeta = const VerificationMeta(
    'requisitos',
  );
  @override
  late final GeneratedColumn<String> requisitos = GeneratedColumn<String>(
    'requisitos',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titulo,
    descripcion,
    empresaId,
    estado,
    fechaLimite,
    vacantes,
    ubicacion,
    areaPractica,
    requisitos,
    createdAt,
    updatedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offer_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfferEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('empresa_id')) {
      context.handle(
        _empresaIdMeta,
        empresaId.isAcceptableOrUnknown(data['empresa_id']!, _empresaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_empresaIdMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('fecha_limite')) {
      context.handle(
        _fechaLimiteMeta,
        fechaLimite.isAcceptableOrUnknown(
          data['fecha_limite']!,
          _fechaLimiteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaLimiteMeta);
    }
    if (data.containsKey('vacantes')) {
      context.handle(
        _vacantesMeta,
        vacantes.isAcceptableOrUnknown(data['vacantes']!, _vacantesMeta),
      );
    }
    if (data.containsKey('ubicacion')) {
      context.handle(
        _ubicacionMeta,
        ubicacion.isAcceptableOrUnknown(data['ubicacion']!, _ubicacionMeta),
      );
    }
    if (data.containsKey('area_practica')) {
      context.handle(
        _areaPracticaMeta,
        areaPractica.isAcceptableOrUnknown(
          data['area_practica']!,
          _areaPracticaMeta,
        ),
      );
    }
    if (data.containsKey('requisitos')) {
      context.handle(
        _requisitosMeta,
        requisitos.isAcceptableOrUnknown(data['requisitos']!, _requisitosMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfferEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfferEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      empresaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}empresa_id'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      fechaLimite: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_limite'],
      )!,
      vacantes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vacantes'],
      )!,
      ubicacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ubicacion'],
      ),
      areaPractica: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area_practica'],
      ),
      requisitos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requisitos'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $OfferEntriesTable createAlias(String alias) {
    return $OfferEntriesTable(attachedDatabase, alias);
  }
}

class OfferEntry extends DataClass implements Insertable<OfferEntry> {
  final String id;
  final String titulo;
  final String descripcion;
  final String empresaId;
  final String estado;
  final DateTime fechaLimite;
  final int vacantes;
  final String? ubicacion;
  final String? areaPractica;
  final String? requisitos;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? lastSyncedAt;
  const OfferEntry({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.empresaId,
    required this.estado,
    required this.fechaLimite,
    required this.vacantes,
    this.ubicacion,
    this.areaPractica,
    this.requisitos,
    required this.createdAt,
    this.updatedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['titulo'] = Variable<String>(titulo);
    map['descripcion'] = Variable<String>(descripcion);
    map['empresa_id'] = Variable<String>(empresaId);
    map['estado'] = Variable<String>(estado);
    map['fecha_limite'] = Variable<DateTime>(fechaLimite);
    map['vacantes'] = Variable<int>(vacantes);
    if (!nullToAbsent || ubicacion != null) {
      map['ubicacion'] = Variable<String>(ubicacion);
    }
    if (!nullToAbsent || areaPractica != null) {
      map['area_practica'] = Variable<String>(areaPractica);
    }
    if (!nullToAbsent || requisitos != null) {
      map['requisitos'] = Variable<String>(requisitos);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  OfferEntriesCompanion toCompanion(bool nullToAbsent) {
    return OfferEntriesCompanion(
      id: Value(id),
      titulo: Value(titulo),
      descripcion: Value(descripcion),
      empresaId: Value(empresaId),
      estado: Value(estado),
      fechaLimite: Value(fechaLimite),
      vacantes: Value(vacantes),
      ubicacion: ubicacion == null && nullToAbsent
          ? const Value.absent()
          : Value(ubicacion),
      areaPractica: areaPractica == null && nullToAbsent
          ? const Value.absent()
          : Value(areaPractica),
      requisitos: requisitos == null && nullToAbsent
          ? const Value.absent()
          : Value(requisitos),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory OfferEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfferEntry(
      id: serializer.fromJson<String>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      empresaId: serializer.fromJson<String>(json['empresaId']),
      estado: serializer.fromJson<String>(json['estado']),
      fechaLimite: serializer.fromJson<DateTime>(json['fechaLimite']),
      vacantes: serializer.fromJson<int>(json['vacantes']),
      ubicacion: serializer.fromJson<String?>(json['ubicacion']),
      areaPractica: serializer.fromJson<String?>(json['areaPractica']),
      requisitos: serializer.fromJson<String?>(json['requisitos']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titulo': serializer.toJson<String>(titulo),
      'descripcion': serializer.toJson<String>(descripcion),
      'empresaId': serializer.toJson<String>(empresaId),
      'estado': serializer.toJson<String>(estado),
      'fechaLimite': serializer.toJson<DateTime>(fechaLimite),
      'vacantes': serializer.toJson<int>(vacantes),
      'ubicacion': serializer.toJson<String?>(ubicacion),
      'areaPractica': serializer.toJson<String?>(areaPractica),
      'requisitos': serializer.toJson<String?>(requisitos),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  OfferEntry copyWith({
    String? id,
    String? titulo,
    String? descripcion,
    String? empresaId,
    String? estado,
    DateTime? fechaLimite,
    int? vacantes,
    Value<String?> ubicacion = const Value.absent(),
    Value<String?> areaPractica = const Value.absent(),
    Value<String?> requisitos = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => OfferEntry(
    id: id ?? this.id,
    titulo: titulo ?? this.titulo,
    descripcion: descripcion ?? this.descripcion,
    empresaId: empresaId ?? this.empresaId,
    estado: estado ?? this.estado,
    fechaLimite: fechaLimite ?? this.fechaLimite,
    vacantes: vacantes ?? this.vacantes,
    ubicacion: ubicacion.present ? ubicacion.value : this.ubicacion,
    areaPractica: areaPractica.present ? areaPractica.value : this.areaPractica,
    requisitos: requisitos.present ? requisitos.value : this.requisitos,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  OfferEntry copyWithCompanion(OfferEntriesCompanion data) {
    return OfferEntry(
      id: data.id.present ? data.id.value : this.id,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      empresaId: data.empresaId.present ? data.empresaId.value : this.empresaId,
      estado: data.estado.present ? data.estado.value : this.estado,
      fechaLimite: data.fechaLimite.present
          ? data.fechaLimite.value
          : this.fechaLimite,
      vacantes: data.vacantes.present ? data.vacantes.value : this.vacantes,
      ubicacion: data.ubicacion.present ? data.ubicacion.value : this.ubicacion,
      areaPractica: data.areaPractica.present
          ? data.areaPractica.value
          : this.areaPractica,
      requisitos: data.requisitos.present
          ? data.requisitos.value
          : this.requisitos,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfferEntry(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('empresaId: $empresaId, ')
          ..write('estado: $estado, ')
          ..write('fechaLimite: $fechaLimite, ')
          ..write('vacantes: $vacantes, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('areaPractica: $areaPractica, ')
          ..write('requisitos: $requisitos, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    titulo,
    descripcion,
    empresaId,
    estado,
    fechaLimite,
    vacantes,
    ubicacion,
    areaPractica,
    requisitos,
    createdAt,
    updatedAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfferEntry &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.descripcion == this.descripcion &&
          other.empresaId == this.empresaId &&
          other.estado == this.estado &&
          other.fechaLimite == this.fechaLimite &&
          other.vacantes == this.vacantes &&
          other.ubicacion == this.ubicacion &&
          other.areaPractica == this.areaPractica &&
          other.requisitos == this.requisitos &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class OfferEntriesCompanion extends UpdateCompanion<OfferEntry> {
  final Value<String> id;
  final Value<String> titulo;
  final Value<String> descripcion;
  final Value<String> empresaId;
  final Value<String> estado;
  final Value<DateTime> fechaLimite;
  final Value<int> vacantes;
  final Value<String?> ubicacion;
  final Value<String?> areaPractica;
  final Value<String?> requisitos;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const OfferEntriesCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.empresaId = const Value.absent(),
    this.estado = const Value.absent(),
    this.fechaLimite = const Value.absent(),
    this.vacantes = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.areaPractica = const Value.absent(),
    this.requisitos = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OfferEntriesCompanion.insert({
    required String id,
    required String titulo,
    required String descripcion,
    required String empresaId,
    this.estado = const Value.absent(),
    required DateTime fechaLimite,
    this.vacantes = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.areaPractica = const Value.absent(),
    this.requisitos = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       titulo = Value(titulo),
       descripcion = Value(descripcion),
       empresaId = Value(empresaId),
       fechaLimite = Value(fechaLimite),
       createdAt = Value(createdAt);
  static Insertable<OfferEntry> custom({
    Expression<String>? id,
    Expression<String>? titulo,
    Expression<String>? descripcion,
    Expression<String>? empresaId,
    Expression<String>? estado,
    Expression<DateTime>? fechaLimite,
    Expression<int>? vacantes,
    Expression<String>? ubicacion,
    Expression<String>? areaPractica,
    Expression<String>? requisitos,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (descripcion != null) 'descripcion': descripcion,
      if (empresaId != null) 'empresa_id': empresaId,
      if (estado != null) 'estado': estado,
      if (fechaLimite != null) 'fecha_limite': fechaLimite,
      if (vacantes != null) 'vacantes': vacantes,
      if (ubicacion != null) 'ubicacion': ubicacion,
      if (areaPractica != null) 'area_practica': areaPractica,
      if (requisitos != null) 'requisitos': requisitos,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OfferEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? titulo,
    Value<String>? descripcion,
    Value<String>? empresaId,
    Value<String>? estado,
    Value<DateTime>? fechaLimite,
    Value<int>? vacantes,
    Value<String?>? ubicacion,
    Value<String?>? areaPractica,
    Value<String?>? requisitos,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return OfferEntriesCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      empresaId: empresaId ?? this.empresaId,
      estado: estado ?? this.estado,
      fechaLimite: fechaLimite ?? this.fechaLimite,
      vacantes: vacantes ?? this.vacantes,
      ubicacion: ubicacion ?? this.ubicacion,
      areaPractica: areaPractica ?? this.areaPractica,
      requisitos: requisitos ?? this.requisitos,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (empresaId.present) {
      map['empresa_id'] = Variable<String>(empresaId.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (fechaLimite.present) {
      map['fecha_limite'] = Variable<DateTime>(fechaLimite.value);
    }
    if (vacantes.present) {
      map['vacantes'] = Variable<int>(vacantes.value);
    }
    if (ubicacion.present) {
      map['ubicacion'] = Variable<String>(ubicacion.value);
    }
    if (areaPractica.present) {
      map['area_practica'] = Variable<String>(areaPractica.value);
    }
    if (requisitos.present) {
      map['requisitos'] = Variable<String>(requisitos.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfferEntriesCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('empresaId: $empresaId, ')
          ..write('estado: $estado, ')
          ..write('fechaLimite: $fechaLimite, ')
          ..write('vacantes: $vacantes, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('areaPractica: $areaPractica, ')
          ..write('requisitos: $requisitos, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PostulationEntriesTable extends PostulationEntries
    with TableInfo<$PostulationEntriesTable, PostulationEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostulationEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ofertaIdMeta = const VerificationMeta(
    'ofertaId',
  );
  @override
  late final GeneratedColumn<String> ofertaId = GeneratedColumn<String>(
    'oferta_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('postulado'),
  );
  static const VerificationMeta _motivoRechazoMeta = const VerificationMeta(
    'motivoRechazo',
  );
  @override
  late final GeneratedColumn<String> motivoRechazo = GeneratedColumn<String>(
    'motivo_rechazo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ofertaId,
    studentId,
    estado,
    motivoRechazo,
    createdAt,
    updatedAt,
    syncStatus,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'postulation_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PostulationEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('oferta_id')) {
      context.handle(
        _ofertaIdMeta,
        ofertaId.isAcceptableOrUnknown(data['oferta_id']!, _ofertaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ofertaIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('motivo_rechazo')) {
      context.handle(
        _motivoRechazoMeta,
        motivoRechazo.isAcceptableOrUnknown(
          data['motivo_rechazo']!,
          _motivoRechazoMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PostulationEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PostulationEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ofertaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}oferta_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      motivoRechazo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo_rechazo'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $PostulationEntriesTable createAlias(String alias) {
    return $PostulationEntriesTable(attachedDatabase, alias);
  }
}

class PostulationEntry extends DataClass
    implements Insertable<PostulationEntry> {
  final String id;
  final String ofertaId;
  final String studentId;
  final String estado;
  final String? motivoRechazo;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String syncStatus;
  final DateTime? lastSyncedAt;
  const PostulationEntry({
    required this.id,
    required this.ofertaId,
    required this.studentId,
    required this.estado,
    this.motivoRechazo,
    required this.createdAt,
    this.updatedAt,
    required this.syncStatus,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['oferta_id'] = Variable<String>(ofertaId);
    map['student_id'] = Variable<String>(studentId);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || motivoRechazo != null) {
      map['motivo_rechazo'] = Variable<String>(motivoRechazo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  PostulationEntriesCompanion toCompanion(bool nullToAbsent) {
    return PostulationEntriesCompanion(
      id: Value(id),
      ofertaId: Value(ofertaId),
      studentId: Value(studentId),
      estado: Value(estado),
      motivoRechazo: motivoRechazo == null && nullToAbsent
          ? const Value.absent()
          : Value(motivoRechazo),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory PostulationEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PostulationEntry(
      id: serializer.fromJson<String>(json['id']),
      ofertaId: serializer.fromJson<String>(json['ofertaId']),
      studentId: serializer.fromJson<String>(json['studentId']),
      estado: serializer.fromJson<String>(json['estado']),
      motivoRechazo: serializer.fromJson<String?>(json['motivoRechazo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ofertaId': serializer.toJson<String>(ofertaId),
      'studentId': serializer.toJson<String>(studentId),
      'estado': serializer.toJson<String>(estado),
      'motivoRechazo': serializer.toJson<String?>(motivoRechazo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  PostulationEntry copyWith({
    String? id,
    String? ofertaId,
    String? studentId,
    String? estado,
    Value<String?> motivoRechazo = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    String? syncStatus,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => PostulationEntry(
    id: id ?? this.id,
    ofertaId: ofertaId ?? this.ofertaId,
    studentId: studentId ?? this.studentId,
    estado: estado ?? this.estado,
    motivoRechazo: motivoRechazo.present
        ? motivoRechazo.value
        : this.motivoRechazo,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  PostulationEntry copyWithCompanion(PostulationEntriesCompanion data) {
    return PostulationEntry(
      id: data.id.present ? data.id.value : this.id,
      ofertaId: data.ofertaId.present ? data.ofertaId.value : this.ofertaId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      estado: data.estado.present ? data.estado.value : this.estado,
      motivoRechazo: data.motivoRechazo.present
          ? data.motivoRechazo.value
          : this.motivoRechazo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PostulationEntry(')
          ..write('id: $id, ')
          ..write('ofertaId: $ofertaId, ')
          ..write('studentId: $studentId, ')
          ..write('estado: $estado, ')
          ..write('motivoRechazo: $motivoRechazo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ofertaId,
    studentId,
    estado,
    motivoRechazo,
    createdAt,
    updatedAt,
    syncStatus,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostulationEntry &&
          other.id == this.id &&
          other.ofertaId == this.ofertaId &&
          other.studentId == this.studentId &&
          other.estado == this.estado &&
          other.motivoRechazo == this.motivoRechazo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class PostulationEntriesCompanion extends UpdateCompanion<PostulationEntry> {
  final Value<String> id;
  final Value<String> ofertaId;
  final Value<String> studentId;
  final Value<String> estado;
  final Value<String?> motivoRechazo;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> syncStatus;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const PostulationEntriesCompanion({
    this.id = const Value.absent(),
    this.ofertaId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.estado = const Value.absent(),
    this.motivoRechazo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostulationEntriesCompanion.insert({
    required String id,
    required String ofertaId,
    required String studentId,
    this.estado = const Value.absent(),
    this.motivoRechazo = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ofertaId = Value(ofertaId),
       studentId = Value(studentId),
       createdAt = Value(createdAt);
  static Insertable<PostulationEntry> custom({
    Expression<String>? id,
    Expression<String>? ofertaId,
    Expression<String>? studentId,
    Expression<String>? estado,
    Expression<String>? motivoRechazo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ofertaId != null) 'oferta_id': ofertaId,
      if (studentId != null) 'student_id': studentId,
      if (estado != null) 'estado': estado,
      if (motivoRechazo != null) 'motivo_rechazo': motivoRechazo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostulationEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? ofertaId,
    Value<String>? studentId,
    Value<String>? estado,
    Value<String?>? motivoRechazo,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<String>? syncStatus,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return PostulationEntriesCompanion(
      id: id ?? this.id,
      ofertaId: ofertaId ?? this.ofertaId,
      studentId: studentId ?? this.studentId,
      estado: estado ?? this.estado,
      motivoRechazo: motivoRechazo ?? this.motivoRechazo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ofertaId.present) {
      map['oferta_id'] = Variable<String>(ofertaId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (motivoRechazo.present) {
      map['motivo_rechazo'] = Variable<String>(motivoRechazo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostulationEntriesCompanion(')
          ..write('id: $id, ')
          ..write('ofertaId: $ofertaId, ')
          ..write('studentId: $studentId, ')
          ..write('estado: $estado, ')
          ..write('motivoRechazo: $motivoRechazo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentEntriesTable extends DocumentEntries
    with TableInfo<$DocumentEntriesTable, DocumentEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaSubidaMeta = const VerificationMeta(
    'fechaSubida',
  );
  @override
  late final GeneratedColumn<DateTime> fechaSubida = GeneratedColumn<DateTime>(
    'fecha_subida',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    tipo,
    url,
    fechaSubida,
    usuarioId,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('fecha_subida')) {
      context.handle(
        _fechaSubidaMeta,
        fechaSubida.isAcceptableOrUnknown(
          data['fecha_subida']!,
          _fechaSubidaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaSubidaMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      fechaSubida: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_subida'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $DocumentEntriesTable createAlias(String alias) {
    return $DocumentEntriesTable(attachedDatabase, alias);
  }
}

class DocumentEntry extends DataClass implements Insertable<DocumentEntry> {
  final String id;
  final String nombre;
  final String tipo;
  final String url;
  final DateTime fechaSubida;
  final String usuarioId;
  final DateTime? lastSyncedAt;
  const DocumentEntry({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.url,
    required this.fechaSubida,
    required this.usuarioId,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['tipo'] = Variable<String>(tipo);
    map['url'] = Variable<String>(url);
    map['fecha_subida'] = Variable<DateTime>(fechaSubida);
    map['usuario_id'] = Variable<String>(usuarioId);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  DocumentEntriesCompanion toCompanion(bool nullToAbsent) {
    return DocumentEntriesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      tipo: Value(tipo),
      url: Value(url),
      fechaSubida: Value(fechaSubida),
      usuarioId: Value(usuarioId),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory DocumentEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentEntry(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      tipo: serializer.fromJson<String>(json['tipo']),
      url: serializer.fromJson<String>(json['url']),
      fechaSubida: serializer.fromJson<DateTime>(json['fechaSubida']),
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'tipo': serializer.toJson<String>(tipo),
      'url': serializer.toJson<String>(url),
      'fechaSubida': serializer.toJson<DateTime>(fechaSubida),
      'usuarioId': serializer.toJson<String>(usuarioId),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  DocumentEntry copyWith({
    String? id,
    String? nombre,
    String? tipo,
    String? url,
    DateTime? fechaSubida,
    String? usuarioId,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => DocumentEntry(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    tipo: tipo ?? this.tipo,
    url: url ?? this.url,
    fechaSubida: fechaSubida ?? this.fechaSubida,
    usuarioId: usuarioId ?? this.usuarioId,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  DocumentEntry copyWithCompanion(DocumentEntriesCompanion data) {
    return DocumentEntry(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      url: data.url.present ? data.url.value : this.url,
      fechaSubida: data.fechaSubida.present
          ? data.fechaSubida.value
          : this.fechaSubida,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentEntry(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('url: $url, ')
          ..write('fechaSubida: $fechaSubida, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, tipo, url, fechaSubida, usuarioId, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentEntry &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.tipo == this.tipo &&
          other.url == this.url &&
          other.fechaSubida == this.fechaSubida &&
          other.usuarioId == this.usuarioId &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class DocumentEntriesCompanion extends UpdateCompanion<DocumentEntry> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> tipo;
  final Value<String> url;
  final Value<DateTime> fechaSubida;
  final Value<String> usuarioId;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const DocumentEntriesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.tipo = const Value.absent(),
    this.url = const Value.absent(),
    this.fechaSubida = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentEntriesCompanion.insert({
    required String id,
    required String nombre,
    required String tipo,
    required String url,
    required DateTime fechaSubida,
    required String usuarioId,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       tipo = Value(tipo),
       url = Value(url),
       fechaSubida = Value(fechaSubida),
       usuarioId = Value(usuarioId);
  static Insertable<DocumentEntry> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? tipo,
    Expression<String>? url,
    Expression<DateTime>? fechaSubida,
    Expression<String>? usuarioId,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (tipo != null) 'tipo': tipo,
      if (url != null) 'url': url,
      if (fechaSubida != null) 'fecha_subida': fechaSubida,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<String>? tipo,
    Value<String>? url,
    Value<DateTime>? fechaSubida,
    Value<String>? usuarioId,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return DocumentEntriesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      url: url ?? this.url,
      fechaSubida: fechaSubida ?? this.fechaSubida,
      usuarioId: usuarioId ?? this.usuarioId,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (fechaSubida.present) {
      map['fecha_subida'] = Variable<DateTime>(fechaSubida.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentEntriesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('url: $url, ')
          ..write('fechaSubida: $fechaSubida, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FollowUpEntriesTable extends FollowUpEntries
    with TableInfo<$FollowUpEntriesTable, FollowUpEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FollowUpEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _comentarioMeta = const VerificationMeta(
    'comentario',
  );
  @override
  late final GeneratedColumn<String> comentario = GeneratedColumn<String>(
    'comentario',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pendiente'),
  );
  static const VerificationMeta _postulacionIdMeta = const VerificationMeta(
    'postulacionId',
  );
  @override
  late final GeneratedColumn<String> postulacionId = GeneratedColumn<String>(
    'postulacion_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fecha,
    comentario,
    estado,
    postulacionId,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'follow_up_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FollowUpEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('comentario')) {
      context.handle(
        _comentarioMeta,
        comentario.isAcceptableOrUnknown(data['comentario']!, _comentarioMeta),
      );
    } else if (isInserting) {
      context.missing(_comentarioMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('postulacion_id')) {
      context.handle(
        _postulacionIdMeta,
        postulacionId.isAcceptableOrUnknown(
          data['postulacion_id']!,
          _postulacionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_postulacionIdMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FollowUpEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FollowUpEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      comentario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comentario'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      postulacionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postulacion_id'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $FollowUpEntriesTable createAlias(String alias) {
    return $FollowUpEntriesTable(attachedDatabase, alias);
  }
}

class FollowUpEntry extends DataClass implements Insertable<FollowUpEntry> {
  final String id;
  final DateTime fecha;
  final String comentario;
  final String estado;
  final String postulacionId;
  final DateTime? lastSyncedAt;
  const FollowUpEntry({
    required this.id,
    required this.fecha,
    required this.comentario,
    required this.estado,
    required this.postulacionId,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['comentario'] = Variable<String>(comentario);
    map['estado'] = Variable<String>(estado);
    map['postulacion_id'] = Variable<String>(postulacionId);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  FollowUpEntriesCompanion toCompanion(bool nullToAbsent) {
    return FollowUpEntriesCompanion(
      id: Value(id),
      fecha: Value(fecha),
      comentario: Value(comentario),
      estado: Value(estado),
      postulacionId: Value(postulacionId),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory FollowUpEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FollowUpEntry(
      id: serializer.fromJson<String>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      comentario: serializer.fromJson<String>(json['comentario']),
      estado: serializer.fromJson<String>(json['estado']),
      postulacionId: serializer.fromJson<String>(json['postulacionId']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'comentario': serializer.toJson<String>(comentario),
      'estado': serializer.toJson<String>(estado),
      'postulacionId': serializer.toJson<String>(postulacionId),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  FollowUpEntry copyWith({
    String? id,
    DateTime? fecha,
    String? comentario,
    String? estado,
    String? postulacionId,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => FollowUpEntry(
    id: id ?? this.id,
    fecha: fecha ?? this.fecha,
    comentario: comentario ?? this.comentario,
    estado: estado ?? this.estado,
    postulacionId: postulacionId ?? this.postulacionId,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  FollowUpEntry copyWithCompanion(FollowUpEntriesCompanion data) {
    return FollowUpEntry(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      comentario: data.comentario.present
          ? data.comentario.value
          : this.comentario,
      estado: data.estado.present ? data.estado.value : this.estado,
      postulacionId: data.postulacionId.present
          ? data.postulacionId.value
          : this.postulacionId,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FollowUpEntry(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('comentario: $comentario, ')
          ..write('estado: $estado, ')
          ..write('postulacionId: $postulacionId, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fecha, comentario, estado, postulacionId, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FollowUpEntry &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.comentario == this.comentario &&
          other.estado == this.estado &&
          other.postulacionId == this.postulacionId &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class FollowUpEntriesCompanion extends UpdateCompanion<FollowUpEntry> {
  final Value<String> id;
  final Value<DateTime> fecha;
  final Value<String> comentario;
  final Value<String> estado;
  final Value<String> postulacionId;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const FollowUpEntriesCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.comentario = const Value.absent(),
    this.estado = const Value.absent(),
    this.postulacionId = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FollowUpEntriesCompanion.insert({
    required String id,
    required DateTime fecha,
    required String comentario,
    this.estado = const Value.absent(),
    required String postulacionId,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fecha = Value(fecha),
       comentario = Value(comentario),
       postulacionId = Value(postulacionId);
  static Insertable<FollowUpEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? fecha,
    Expression<String>? comentario,
    Expression<String>? estado,
    Expression<String>? postulacionId,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (comentario != null) 'comentario': comentario,
      if (estado != null) 'estado': estado,
      if (postulacionId != null) 'postulacion_id': postulacionId,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FollowUpEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? fecha,
    Value<String>? comentario,
    Value<String>? estado,
    Value<String>? postulacionId,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return FollowUpEntriesCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      comentario: comentario ?? this.comentario,
      estado: estado ?? this.estado,
      postulacionId: postulacionId ?? this.postulacionId,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (comentario.present) {
      map['comentario'] = Variable<String>(comentario.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (postulacionId.present) {
      map['postulacion_id'] = Variable<String>(postulacionId.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FollowUpEntriesCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('comentario: $comentario, ')
          ..write('estado: $estado, ')
          ..write('postulacionId: $postulacionId, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompanyEntriesTable extends CompanyEntries
    with TableInfo<$CompanyEntriesTable, CompanyEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ubicacionMeta = const VerificationMeta(
    'ubicacion',
  );
  @override
  late final GeneratedColumn<String> ubicacion = GeneratedColumn<String>(
    'ubicacion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactoMeta = const VerificationMeta(
    'contacto',
  );
  @override
  late final GeneratedColumn<String> contacto = GeneratedColumn<String>(
    'contacto',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    descripcion,
    ubicacion,
    contacto,
    createdAt,
    updatedAt,
    isActive,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompanyEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('ubicacion')) {
      context.handle(
        _ubicacionMeta,
        ubicacion.isAcceptableOrUnknown(data['ubicacion']!, _ubicacionMeta),
      );
    }
    if (data.containsKey('contacto')) {
      context.handle(
        _contactoMeta,
        contacto.isAcceptableOrUnknown(data['contacto']!, _contactoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompanyEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      ubicacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ubicacion'],
      ),
      contacto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contacto'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $CompanyEntriesTable createAlias(String alias) {
    return $CompanyEntriesTable(attachedDatabase, alias);
  }
}

class CompanyEntry extends DataClass implements Insertable<CompanyEntry> {
  final String id;
  final String nombre;
  final String? descripcion;
  final String? ubicacion;
  final String? contacto;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final DateTime? lastSyncedAt;
  const CompanyEntry({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.ubicacion,
    this.contacto,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || ubicacion != null) {
      map['ubicacion'] = Variable<String>(ubicacion);
    }
    if (!nullToAbsent || contacto != null) {
      map['contacto'] = Variable<String>(contacto);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  CompanyEntriesCompanion toCompanion(bool nullToAbsent) {
    return CompanyEntriesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      ubicacion: ubicacion == null && nullToAbsent
          ? const Value.absent()
          : Value(ubicacion),
      contacto: contacto == null && nullToAbsent
          ? const Value.absent()
          : Value(contacto),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isActive: Value(isActive),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory CompanyEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyEntry(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      ubicacion: serializer.fromJson<String?>(json['ubicacion']),
      contacto: serializer.fromJson<String?>(json['contacto']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'ubicacion': serializer.toJson<String?>(ubicacion),
      'contacto': serializer.toJson<String?>(contacto),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isActive': serializer.toJson<bool>(isActive),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  CompanyEntry copyWith({
    String? id,
    String? nombre,
    Value<String?> descripcion = const Value.absent(),
    Value<String?> ubicacion = const Value.absent(),
    Value<String?> contacto = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    bool? isActive,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => CompanyEntry(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    ubicacion: ubicacion.present ? ubicacion.value : this.ubicacion,
    contacto: contacto.present ? contacto.value : this.contacto,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    isActive: isActive ?? this.isActive,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  CompanyEntry copyWithCompanion(CompanyEntriesCompanion data) {
    return CompanyEntry(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      ubicacion: data.ubicacion.present ? data.ubicacion.value : this.ubicacion,
      contacto: data.contacto.present ? data.contacto.value : this.contacto,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyEntry(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('contacto: $contacto, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    descripcion,
    ubicacion,
    contacto,
    createdAt,
    updatedAt,
    isActive,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyEntry &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.ubicacion == this.ubicacion &&
          other.contacto == this.contacto &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isActive == this.isActive &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class CompanyEntriesCompanion extends UpdateCompanion<CompanyEntry> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<String?> ubicacion;
  final Value<String?> contacto;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isActive;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const CompanyEntriesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.contacto = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompanyEntriesCompanion.insert({
    required String id,
    required String nombre,
    this.descripcion = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.contacto = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       createdAt = Value(createdAt);
  static Insertable<CompanyEntry> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<String>? ubicacion,
    Expression<String>? contacto,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isActive,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (ubicacion != null) 'ubicacion': ubicacion,
      if (contacto != null) 'contacto': contacto,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isActive != null) 'is_active': isActive,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompanyEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<String?>? descripcion,
    Value<String?>? ubicacion,
    Value<String?>? contacto,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<bool>? isActive,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return CompanyEntriesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      ubicacion: ubicacion ?? this.ubicacion,
      contacto: contacto ?? this.contacto,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (ubicacion.present) {
      map['ubicacion'] = Variable<String>(ubicacion.value);
    }
    if (contacto.present) {
      map['contacto'] = Variable<String>(contacto.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyEntriesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('contacto: $contacto, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingOperationEntriesTable extends PendingOperationEntries
    with TableInfo<$PendingOperationEntriesTable, PendingOperationEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingOperationEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _operationTypeMeta = const VerificationMeta(
    'operationType',
  );
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
    'operation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    operationType,
    entityType,
    entityId,
    payload,
    synced,
    retryCount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_operation_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingOperationEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation_type')) {
      context.handle(
        _operationTypeMeta,
        operationType.isAcceptableOrUnknown(
          data['operation_type']!,
          _operationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingOperationEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingOperationEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      operationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_type'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PendingOperationEntriesTable createAlias(String alias) {
    return $PendingOperationEntriesTable(attachedDatabase, alias);
  }
}

class PendingOperationEntry extends DataClass
    implements Insertable<PendingOperationEntry> {
  final int id;
  final String operationType;
  final String entityType;
  final String entityId;
  final String payload;
  final bool synced;
  final int retryCount;
  final DateTime createdAt;
  const PendingOperationEntry({
    required this.id,
    required this.operationType,
    required this.entityType,
    required this.entityId,
    required this.payload,
    required this.synced,
    required this.retryCount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation_type'] = Variable<String>(operationType);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['payload'] = Variable<String>(payload);
    map['synced'] = Variable<bool>(synced);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PendingOperationEntriesCompanion toCompanion(bool nullToAbsent) {
    return PendingOperationEntriesCompanion(
      id: Value(id),
      operationType: Value(operationType),
      entityType: Value(entityType),
      entityId: Value(entityId),
      payload: Value(payload),
      synced: Value(synced),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
    );
  }

  factory PendingOperationEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingOperationEntry(
      id: serializer.fromJson<int>(json['id']),
      operationType: serializer.fromJson<String>(json['operationType']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      payload: serializer.fromJson<String>(json['payload']),
      synced: serializer.fromJson<bool>(json['synced']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operationType': serializer.toJson<String>(operationType),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'payload': serializer.toJson<String>(payload),
      'synced': serializer.toJson<bool>(synced),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PendingOperationEntry copyWith({
    int? id,
    String? operationType,
    String? entityType,
    String? entityId,
    String? payload,
    bool? synced,
    int? retryCount,
    DateTime? createdAt,
  }) => PendingOperationEntry(
    id: id ?? this.id,
    operationType: operationType ?? this.operationType,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    payload: payload ?? this.payload,
    synced: synced ?? this.synced,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
  );
  PendingOperationEntry copyWithCompanion(
    PendingOperationEntriesCompanion data,
  ) {
    return PendingOperationEntry(
      id: data.id.present ? data.id.value : this.id,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      payload: data.payload.present ? data.payload.value : this.payload,
      synced: data.synced.present ? data.synced.value : this.synced,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperationEntry(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('payload: $payload, ')
          ..write('synced: $synced, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    operationType,
    entityType,
    entityId,
    payload,
    synced,
    retryCount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingOperationEntry &&
          other.id == this.id &&
          other.operationType == this.operationType &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.payload == this.payload &&
          other.synced == this.synced &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt);
}

class PendingOperationEntriesCompanion
    extends UpdateCompanion<PendingOperationEntry> {
  final Value<int> id;
  final Value<String> operationType;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> payload;
  final Value<bool> synced;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  const PendingOperationEntriesCompanion({
    this.id = const Value.absent(),
    this.operationType = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.payload = const Value.absent(),
    this.synced = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PendingOperationEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String operationType,
    required String entityType,
    required String entityId,
    required String payload,
    this.synced = const Value.absent(),
    this.retryCount = const Value.absent(),
    required DateTime createdAt,
  }) : operationType = Value(operationType),
       entityType = Value(entityType),
       entityId = Value(entityId),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<PendingOperationEntry> custom({
    Expression<int>? id,
    Expression<String>? operationType,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? payload,
    Expression<bool>? synced,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operationType != null) 'operation_type': operationType,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (payload != null) 'payload': payload,
      if (synced != null) 'synced': synced,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PendingOperationEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? operationType,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? payload,
    Value<bool>? synced,
    Value<int>? retryCount,
    Value<DateTime>? createdAt,
  }) {
    return PendingOperationEntriesCompanion(
      id: id ?? this.id,
      operationType: operationType ?? this.operationType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      payload: payload ?? this.payload,
      synced: synced ?? this.synced,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingOperationEntriesCompanion(')
          ..write('id: $id, ')
          ..write('operationType: $operationType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('payload: $payload, ')
          ..write('synced: $synced, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserEntriesTable userEntries = $UserEntriesTable(this);
  late final $OfferEntriesTable offerEntries = $OfferEntriesTable(this);
  late final $PostulationEntriesTable postulationEntries =
      $PostulationEntriesTable(this);
  late final $DocumentEntriesTable documentEntries = $DocumentEntriesTable(
    this,
  );
  late final $FollowUpEntriesTable followUpEntries = $FollowUpEntriesTable(
    this,
  );
  late final $CompanyEntriesTable companyEntries = $CompanyEntriesTable(this);
  late final $PendingOperationEntriesTable pendingOperationEntries =
      $PendingOperationEntriesTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final OfferDao offerDao = OfferDao(this as AppDatabase);
  late final PostulationDao postulationDao = PostulationDao(
    this as AppDatabase,
  );
  late final DocumentDao documentDao = DocumentDao(this as AppDatabase);
  late final FollowUpDao followUpDao = FollowUpDao(this as AppDatabase);
  late final CompanyDao companyDao = CompanyDao(this as AppDatabase);
  late final PendingOperationsDao pendingOperationsDao = PendingOperationsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userEntries,
    offerEntries,
    postulationEntries,
    documentEntries,
    followUpEntries,
    companyEntries,
    pendingOperationEntries,
  ];
}

typedef $$UserEntriesTableCreateCompanionBuilder =
    UserEntriesCompanion Function({
      required String uid,
      required String email,
      required String displayName,
      Value<String> role,
      Value<String> status,
      required DateTime createdAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$UserEntriesTableUpdateCompanionBuilder =
    UserEntriesCompanion Function({
      Value<String> uid,
      Value<String> email,
      Value<String> displayName,
      Value<String> role,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$UserEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $UserEntriesTable> {
  $$UserEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserEntriesTable> {
  $$UserEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserEntriesTable> {
  $$UserEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$UserEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserEntriesTable,
          UserEntry,
          $$UserEntriesTableFilterComposer,
          $$UserEntriesTableOrderingComposer,
          $$UserEntriesTableAnnotationComposer,
          $$UserEntriesTableCreateCompanionBuilder,
          $$UserEntriesTableUpdateCompanionBuilder,
          (
            UserEntry,
            BaseReferences<_$AppDatabase, $UserEntriesTable, UserEntry>,
          ),
          UserEntry,
          PrefetchHooks Function()
        > {
  $$UserEntriesTableTableManager(_$AppDatabase db, $UserEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uid = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserEntriesCompanion(
                uid: uid,
                email: email,
                displayName: displayName,
                role: role,
                status: status,
                createdAt: createdAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uid,
                required String email,
                required String displayName,
                Value<String> role = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserEntriesCompanion.insert(
                uid: uid,
                email: email,
                displayName: displayName,
                role: role,
                status: status,
                createdAt: createdAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserEntriesTable,
      UserEntry,
      $$UserEntriesTableFilterComposer,
      $$UserEntriesTableOrderingComposer,
      $$UserEntriesTableAnnotationComposer,
      $$UserEntriesTableCreateCompanionBuilder,
      $$UserEntriesTableUpdateCompanionBuilder,
      (UserEntry, BaseReferences<_$AppDatabase, $UserEntriesTable, UserEntry>),
      UserEntry,
      PrefetchHooks Function()
    >;
typedef $$OfferEntriesTableCreateCompanionBuilder =
    OfferEntriesCompanion Function({
      required String id,
      required String titulo,
      required String descripcion,
      required String empresaId,
      Value<String> estado,
      required DateTime fechaLimite,
      Value<int> vacantes,
      Value<String?> ubicacion,
      Value<String?> areaPractica,
      Value<String?> requisitos,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$OfferEntriesTableUpdateCompanionBuilder =
    OfferEntriesCompanion Function({
      Value<String> id,
      Value<String> titulo,
      Value<String> descripcion,
      Value<String> empresaId,
      Value<String> estado,
      Value<DateTime> fechaLimite,
      Value<int> vacantes,
      Value<String?> ubicacion,
      Value<String?> areaPractica,
      Value<String?> requisitos,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$OfferEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $OfferEntriesTable> {
  $$OfferEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get empresaId => $composableBuilder(
    column: $table.empresaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vacantes => $composableBuilder(
    column: $table.vacantes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get areaPractica => $composableBuilder(
    column: $table.areaPractica,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requisitos => $composableBuilder(
    column: $table.requisitos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OfferEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $OfferEntriesTable> {
  $$OfferEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get empresaId => $composableBuilder(
    column: $table.empresaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vacantes => $composableBuilder(
    column: $table.vacantes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get areaPractica => $composableBuilder(
    column: $table.areaPractica,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requisitos => $composableBuilder(
    column: $table.requisitos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OfferEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfferEntriesTable> {
  $$OfferEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get empresaId =>
      $composableBuilder(column: $table.empresaId, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vacantes =>
      $composableBuilder(column: $table.vacantes, builder: (column) => column);

  GeneratedColumn<String> get ubicacion =>
      $composableBuilder(column: $table.ubicacion, builder: (column) => column);

  GeneratedColumn<String> get areaPractica => $composableBuilder(
    column: $table.areaPractica,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requisitos => $composableBuilder(
    column: $table.requisitos,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$OfferEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OfferEntriesTable,
          OfferEntry,
          $$OfferEntriesTableFilterComposer,
          $$OfferEntriesTableOrderingComposer,
          $$OfferEntriesTableAnnotationComposer,
          $$OfferEntriesTableCreateCompanionBuilder,
          $$OfferEntriesTableUpdateCompanionBuilder,
          (
            OfferEntry,
            BaseReferences<_$AppDatabase, $OfferEntriesTable, OfferEntry>,
          ),
          OfferEntry,
          PrefetchHooks Function()
        > {
  $$OfferEntriesTableTableManager(_$AppDatabase db, $OfferEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfferEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfferEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfferEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<String> empresaId = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<DateTime> fechaLimite = const Value.absent(),
                Value<int> vacantes = const Value.absent(),
                Value<String?> ubicacion = const Value.absent(),
                Value<String?> areaPractica = const Value.absent(),
                Value<String?> requisitos = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OfferEntriesCompanion(
                id: id,
                titulo: titulo,
                descripcion: descripcion,
                empresaId: empresaId,
                estado: estado,
                fechaLimite: fechaLimite,
                vacantes: vacantes,
                ubicacion: ubicacion,
                areaPractica: areaPractica,
                requisitos: requisitos,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String titulo,
                required String descripcion,
                required String empresaId,
                Value<String> estado = const Value.absent(),
                required DateTime fechaLimite,
                Value<int> vacantes = const Value.absent(),
                Value<String?> ubicacion = const Value.absent(),
                Value<String?> areaPractica = const Value.absent(),
                Value<String?> requisitos = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OfferEntriesCompanion.insert(
                id: id,
                titulo: titulo,
                descripcion: descripcion,
                empresaId: empresaId,
                estado: estado,
                fechaLimite: fechaLimite,
                vacantes: vacantes,
                ubicacion: ubicacion,
                areaPractica: areaPractica,
                requisitos: requisitos,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OfferEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OfferEntriesTable,
      OfferEntry,
      $$OfferEntriesTableFilterComposer,
      $$OfferEntriesTableOrderingComposer,
      $$OfferEntriesTableAnnotationComposer,
      $$OfferEntriesTableCreateCompanionBuilder,
      $$OfferEntriesTableUpdateCompanionBuilder,
      (
        OfferEntry,
        BaseReferences<_$AppDatabase, $OfferEntriesTable, OfferEntry>,
      ),
      OfferEntry,
      PrefetchHooks Function()
    >;
typedef $$PostulationEntriesTableCreateCompanionBuilder =
    PostulationEntriesCompanion Function({
      required String id,
      required String ofertaId,
      required String studentId,
      Value<String> estado,
      Value<String?> motivoRechazo,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<String> syncStatus,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$PostulationEntriesTableUpdateCompanionBuilder =
    PostulationEntriesCompanion Function({
      Value<String> id,
      Value<String> ofertaId,
      Value<String> studentId,
      Value<String> estado,
      Value<String?> motivoRechazo,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<String> syncStatus,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$PostulationEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PostulationEntriesTable> {
  $$PostulationEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ofertaId => $composableBuilder(
    column: $table.ofertaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivoRechazo => $composableBuilder(
    column: $table.motivoRechazo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PostulationEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PostulationEntriesTable> {
  $$PostulationEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ofertaId => $composableBuilder(
    column: $table.ofertaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivoRechazo => $composableBuilder(
    column: $table.motivoRechazo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PostulationEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PostulationEntriesTable> {
  $$PostulationEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ofertaId =>
      $composableBuilder(column: $table.ofertaId, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get motivoRechazo => $composableBuilder(
    column: $table.motivoRechazo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$PostulationEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PostulationEntriesTable,
          PostulationEntry,
          $$PostulationEntriesTableFilterComposer,
          $$PostulationEntriesTableOrderingComposer,
          $$PostulationEntriesTableAnnotationComposer,
          $$PostulationEntriesTableCreateCompanionBuilder,
          $$PostulationEntriesTableUpdateCompanionBuilder,
          (
            PostulationEntry,
            BaseReferences<
              _$AppDatabase,
              $PostulationEntriesTable,
              PostulationEntry
            >,
          ),
          PostulationEntry,
          PrefetchHooks Function()
        > {
  $$PostulationEntriesTableTableManager(
    _$AppDatabase db,
    $PostulationEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostulationEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostulationEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostulationEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ofertaId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String?> motivoRechazo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostulationEntriesCompanion(
                id: id,
                ofertaId: ofertaId,
                studentId: studentId,
                estado: estado,
                motivoRechazo: motivoRechazo,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ofertaId,
                required String studentId,
                Value<String> estado = const Value.absent(),
                Value<String?> motivoRechazo = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostulationEntriesCompanion.insert(
                id: id,
                ofertaId: ofertaId,
                studentId: studentId,
                estado: estado,
                motivoRechazo: motivoRechazo,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PostulationEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PostulationEntriesTable,
      PostulationEntry,
      $$PostulationEntriesTableFilterComposer,
      $$PostulationEntriesTableOrderingComposer,
      $$PostulationEntriesTableAnnotationComposer,
      $$PostulationEntriesTableCreateCompanionBuilder,
      $$PostulationEntriesTableUpdateCompanionBuilder,
      (
        PostulationEntry,
        BaseReferences<
          _$AppDatabase,
          $PostulationEntriesTable,
          PostulationEntry
        >,
      ),
      PostulationEntry,
      PrefetchHooks Function()
    >;
typedef $$DocumentEntriesTableCreateCompanionBuilder =
    DocumentEntriesCompanion Function({
      required String id,
      required String nombre,
      required String tipo,
      required String url,
      required DateTime fechaSubida,
      required String usuarioId,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$DocumentEntriesTableUpdateCompanionBuilder =
    DocumentEntriesCompanion Function({
      Value<String> id,
      Value<String> nombre,
      Value<String> tipo,
      Value<String> url,
      Value<DateTime> fechaSubida,
      Value<String> usuarioId,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$DocumentEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentEntriesTable> {
  $$DocumentEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaSubida => $composableBuilder(
    column: $table.fechaSubida,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentEntriesTable> {
  $$DocumentEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaSubida => $composableBuilder(
    column: $table.fechaSubida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentEntriesTable> {
  $$DocumentEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaSubida => $composableBuilder(
    column: $table.fechaSubida,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$DocumentEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentEntriesTable,
          DocumentEntry,
          $$DocumentEntriesTableFilterComposer,
          $$DocumentEntriesTableOrderingComposer,
          $$DocumentEntriesTableAnnotationComposer,
          $$DocumentEntriesTableCreateCompanionBuilder,
          $$DocumentEntriesTableUpdateCompanionBuilder,
          (
            DocumentEntry,
            BaseReferences<_$AppDatabase, $DocumentEntriesTable, DocumentEntry>,
          ),
          DocumentEntry,
          PrefetchHooks Function()
        > {
  $$DocumentEntriesTableTableManager(
    _$AppDatabase db,
    $DocumentEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<DateTime> fechaSubida = const Value.absent(),
                Value<String> usuarioId = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentEntriesCompanion(
                id: id,
                nombre: nombre,
                tipo: tipo,
                url: url,
                fechaSubida: fechaSubida,
                usuarioId: usuarioId,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                required String tipo,
                required String url,
                required DateTime fechaSubida,
                required String usuarioId,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentEntriesCompanion.insert(
                id: id,
                nombre: nombre,
                tipo: tipo,
                url: url,
                fechaSubida: fechaSubida,
                usuarioId: usuarioId,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentEntriesTable,
      DocumentEntry,
      $$DocumentEntriesTableFilterComposer,
      $$DocumentEntriesTableOrderingComposer,
      $$DocumentEntriesTableAnnotationComposer,
      $$DocumentEntriesTableCreateCompanionBuilder,
      $$DocumentEntriesTableUpdateCompanionBuilder,
      (
        DocumentEntry,
        BaseReferences<_$AppDatabase, $DocumentEntriesTable, DocumentEntry>,
      ),
      DocumentEntry,
      PrefetchHooks Function()
    >;
typedef $$FollowUpEntriesTableCreateCompanionBuilder =
    FollowUpEntriesCompanion Function({
      required String id,
      required DateTime fecha,
      required String comentario,
      Value<String> estado,
      required String postulacionId,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$FollowUpEntriesTableUpdateCompanionBuilder =
    FollowUpEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> fecha,
      Value<String> comentario,
      Value<String> estado,
      Value<String> postulacionId,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$FollowUpEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FollowUpEntriesTable> {
  $$FollowUpEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postulacionId => $composableBuilder(
    column: $table.postulacionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FollowUpEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FollowUpEntriesTable> {
  $$FollowUpEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postulacionId => $composableBuilder(
    column: $table.postulacionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FollowUpEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FollowUpEntriesTable> {
  $$FollowUpEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get postulacionId => $composableBuilder(
    column: $table.postulacionId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$FollowUpEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FollowUpEntriesTable,
          FollowUpEntry,
          $$FollowUpEntriesTableFilterComposer,
          $$FollowUpEntriesTableOrderingComposer,
          $$FollowUpEntriesTableAnnotationComposer,
          $$FollowUpEntriesTableCreateCompanionBuilder,
          $$FollowUpEntriesTableUpdateCompanionBuilder,
          (
            FollowUpEntry,
            BaseReferences<_$AppDatabase, $FollowUpEntriesTable, FollowUpEntry>,
          ),
          FollowUpEntry,
          PrefetchHooks Function()
        > {
  $$FollowUpEntriesTableTableManager(
    _$AppDatabase db,
    $FollowUpEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FollowUpEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FollowUpEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FollowUpEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String> comentario = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String> postulacionId = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FollowUpEntriesCompanion(
                id: id,
                fecha: fecha,
                comentario: comentario,
                estado: estado,
                postulacionId: postulacionId,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime fecha,
                required String comentario,
                Value<String> estado = const Value.absent(),
                required String postulacionId,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FollowUpEntriesCompanion.insert(
                id: id,
                fecha: fecha,
                comentario: comentario,
                estado: estado,
                postulacionId: postulacionId,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FollowUpEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FollowUpEntriesTable,
      FollowUpEntry,
      $$FollowUpEntriesTableFilterComposer,
      $$FollowUpEntriesTableOrderingComposer,
      $$FollowUpEntriesTableAnnotationComposer,
      $$FollowUpEntriesTableCreateCompanionBuilder,
      $$FollowUpEntriesTableUpdateCompanionBuilder,
      (
        FollowUpEntry,
        BaseReferences<_$AppDatabase, $FollowUpEntriesTable, FollowUpEntry>,
      ),
      FollowUpEntry,
      PrefetchHooks Function()
    >;
typedef $$CompanyEntriesTableCreateCompanionBuilder =
    CompanyEntriesCompanion Function({
      required String id,
      required String nombre,
      Value<String?> descripcion,
      Value<String?> ubicacion,
      Value<String?> contacto,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<bool> isActive,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$CompanyEntriesTableUpdateCompanionBuilder =
    CompanyEntriesCompanion Function({
      Value<String> id,
      Value<String> nombre,
      Value<String?> descripcion,
      Value<String?> ubicacion,
      Value<String?> contacto,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<bool> isActive,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$CompanyEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CompanyEntriesTable> {
  $$CompanyEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contacto => $composableBuilder(
    column: $table.contacto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompanyEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanyEntriesTable> {
  $$CompanyEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contacto => $composableBuilder(
    column: $table.contacto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompanyEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanyEntriesTable> {
  $$CompanyEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ubicacion =>
      $composableBuilder(column: $table.ubicacion, builder: (column) => column);

  GeneratedColumn<String> get contacto =>
      $composableBuilder(column: $table.contacto, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$CompanyEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompanyEntriesTable,
          CompanyEntry,
          $$CompanyEntriesTableFilterComposer,
          $$CompanyEntriesTableOrderingComposer,
          $$CompanyEntriesTableAnnotationComposer,
          $$CompanyEntriesTableCreateCompanionBuilder,
          $$CompanyEntriesTableUpdateCompanionBuilder,
          (
            CompanyEntry,
            BaseReferences<_$AppDatabase, $CompanyEntriesTable, CompanyEntry>,
          ),
          CompanyEntry,
          PrefetchHooks Function()
        > {
  $$CompanyEntriesTableTableManager(
    _$AppDatabase db,
    $CompanyEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanyEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanyEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanyEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String?> ubicacion = const Value.absent(),
                Value<String?> contacto = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompanyEntriesCompanion(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                ubicacion: ubicacion,
                contacto: contacto,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isActive: isActive,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                Value<String?> descripcion = const Value.absent(),
                Value<String?> ubicacion = const Value.absent(),
                Value<String?> contacto = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompanyEntriesCompanion.insert(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                ubicacion: ubicacion,
                contacto: contacto,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isActive: isActive,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompanyEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompanyEntriesTable,
      CompanyEntry,
      $$CompanyEntriesTableFilterComposer,
      $$CompanyEntriesTableOrderingComposer,
      $$CompanyEntriesTableAnnotationComposer,
      $$CompanyEntriesTableCreateCompanionBuilder,
      $$CompanyEntriesTableUpdateCompanionBuilder,
      (
        CompanyEntry,
        BaseReferences<_$AppDatabase, $CompanyEntriesTable, CompanyEntry>,
      ),
      CompanyEntry,
      PrefetchHooks Function()
    >;
typedef $$PendingOperationEntriesTableCreateCompanionBuilder =
    PendingOperationEntriesCompanion Function({
      Value<int> id,
      required String operationType,
      required String entityType,
      required String entityId,
      required String payload,
      Value<bool> synced,
      Value<int> retryCount,
      required DateTime createdAt,
    });
typedef $$PendingOperationEntriesTableUpdateCompanionBuilder =
    PendingOperationEntriesCompanion Function({
      Value<int> id,
      Value<String> operationType,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> payload,
      Value<bool> synced,
      Value<int> retryCount,
      Value<DateTime> createdAt,
    });

class $$PendingOperationEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PendingOperationEntriesTable> {
  $$PendingOperationEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingOperationEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingOperationEntriesTable> {
  $$PendingOperationEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingOperationEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingOperationEntriesTable> {
  $$PendingOperationEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PendingOperationEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingOperationEntriesTable,
          PendingOperationEntry,
          $$PendingOperationEntriesTableFilterComposer,
          $$PendingOperationEntriesTableOrderingComposer,
          $$PendingOperationEntriesTableAnnotationComposer,
          $$PendingOperationEntriesTableCreateCompanionBuilder,
          $$PendingOperationEntriesTableUpdateCompanionBuilder,
          (
            PendingOperationEntry,
            BaseReferences<
              _$AppDatabase,
              $PendingOperationEntriesTable,
              PendingOperationEntry
            >,
          ),
          PendingOperationEntry,
          PrefetchHooks Function()
        > {
  $$PendingOperationEntriesTableTableManager(
    _$AppDatabase db,
    $PendingOperationEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingOperationEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PendingOperationEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PendingOperationEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> operationType = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PendingOperationEntriesCompanion(
                id: id,
                operationType: operationType,
                entityType: entityType,
                entityId: entityId,
                payload: payload,
                synced: synced,
                retryCount: retryCount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String operationType,
                required String entityType,
                required String entityId,
                required String payload,
                Value<bool> synced = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                required DateTime createdAt,
              }) => PendingOperationEntriesCompanion.insert(
                id: id,
                operationType: operationType,
                entityType: entityType,
                entityId: entityId,
                payload: payload,
                synced: synced,
                retryCount: retryCount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingOperationEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingOperationEntriesTable,
      PendingOperationEntry,
      $$PendingOperationEntriesTableFilterComposer,
      $$PendingOperationEntriesTableOrderingComposer,
      $$PendingOperationEntriesTableAnnotationComposer,
      $$PendingOperationEntriesTableCreateCompanionBuilder,
      $$PendingOperationEntriesTableUpdateCompanionBuilder,
      (
        PendingOperationEntry,
        BaseReferences<
          _$AppDatabase,
          $PendingOperationEntriesTable,
          PendingOperationEntry
        >,
      ),
      PendingOperationEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserEntriesTableTableManager get userEntries =>
      $$UserEntriesTableTableManager(_db, _db.userEntries);
  $$OfferEntriesTableTableManager get offerEntries =>
      $$OfferEntriesTableTableManager(_db, _db.offerEntries);
  $$PostulationEntriesTableTableManager get postulationEntries =>
      $$PostulationEntriesTableTableManager(_db, _db.postulationEntries);
  $$DocumentEntriesTableTableManager get documentEntries =>
      $$DocumentEntriesTableTableManager(_db, _db.documentEntries);
  $$FollowUpEntriesTableTableManager get followUpEntries =>
      $$FollowUpEntriesTableTableManager(_db, _db.followUpEntries);
  $$CompanyEntriesTableTableManager get companyEntries =>
      $$CompanyEntriesTableTableManager(_db, _db.companyEntries);
  $$PendingOperationEntriesTableTableManager get pendingOperationEntries =>
      $$PendingOperationEntriesTableTableManager(
        _db,
        _db.pendingOperationEntries,
      );
}
