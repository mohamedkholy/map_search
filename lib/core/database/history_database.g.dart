// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_database.dart';

// ignore_for_file: type=lint
class $HistoryTable extends History with TableInfo<$HistoryTable, HistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
    'place_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenceMeta = const VerificationMeta(
    'licence',
  );
  @override
  late final GeneratedColumn<String> licence = GeneratedColumn<String>(
    'licence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _osmTypeMeta = const VerificationMeta(
    'osmType',
  );
  @override
  late final GeneratedColumn<String> osmType = GeneratedColumn<String>(
    'osm_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _osmIdMeta = const VerificationMeta('osmId');
  @override
  late final GeneratedColumn<int> osmId = GeneratedColumn<int>(
    'osm_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<String> lat = GeneratedColumn<String>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<String> lon = GeneratedColumn<String>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classNameMeta = const VerificationMeta(
    'className',
  );
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
    'class',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _placeRankMeta = const VerificationMeta(
    'placeRank',
  );
  @override
  late final GeneratedColumn<int> placeRank = GeneratedColumn<int>(
    'place_rank',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importanceMeta = const VerificationMeta(
    'importance',
  );
  @override
  late final GeneratedColumn<double> importance = GeneratedColumn<double>(
    'importance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addresstypeMeta = const VerificationMeta(
    'addresstype',
  );
  @override
  late final GeneratedColumn<String> addresstype = GeneratedColumn<String>(
    'addresstype',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
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
  static const VerificationMeta _boundingboxMeta = const VerificationMeta(
    'boundingbox',
  );
  @override
  late final GeneratedColumn<String> boundingbox = GeneratedColumn<String>(
    'boundingbox',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    placeId,
    licence,
    osmType,
    osmId,
    lat,
    lon,
    className,
    type,
    placeRank,
    importance,
    addresstype,
    name,
    displayName,
    boundingbox,
    address,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    }
    if (data.containsKey('licence')) {
      context.handle(
        _licenceMeta,
        licence.isAcceptableOrUnknown(data['licence']!, _licenceMeta),
      );
    } else if (isInserting) {
      context.missing(_licenceMeta);
    }
    if (data.containsKey('osm_type')) {
      context.handle(
        _osmTypeMeta,
        osmType.isAcceptableOrUnknown(data['osm_type']!, _osmTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_osmTypeMeta);
    }
    if (data.containsKey('osm_id')) {
      context.handle(
        _osmIdMeta,
        osmId.isAcceptableOrUnknown(data['osm_id']!, _osmIdMeta),
      );
    } else if (isInserting) {
      context.missing(_osmIdMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('class')) {
      context.handle(
        _classNameMeta,
        className.isAcceptableOrUnknown(data['class']!, _classNameMeta),
      );
    } else if (isInserting) {
      context.missing(_classNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('place_rank')) {
      context.handle(
        _placeRankMeta,
        placeRank.isAcceptableOrUnknown(data['place_rank']!, _placeRankMeta),
      );
    } else if (isInserting) {
      context.missing(_placeRankMeta);
    }
    if (data.containsKey('importance')) {
      context.handle(
        _importanceMeta,
        importance.isAcceptableOrUnknown(data['importance']!, _importanceMeta),
      );
    } else if (isInserting) {
      context.missing(_importanceMeta);
    }
    if (data.containsKey('addresstype')) {
      context.handle(
        _addresstypeMeta,
        addresstype.isAcceptableOrUnknown(
          data['addresstype']!,
          _addresstypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_addresstypeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('boundingbox')) {
      context.handle(
        _boundingboxMeta,
        boundingbox.isAcceptableOrUnknown(
          data['boundingbox']!,
          _boundingboxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_boundingboxMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {placeId};
  @override
  HistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryData(
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}place_id'],
      )!,
      licence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}licence'],
      )!,
      osmType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}osm_type'],
      )!,
      osmId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}osm_id'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lon'],
      )!,
      className: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      placeRank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}place_rank'],
      )!,
      importance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}importance'],
      )!,
      addresstype: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}addresstype'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      boundingbox: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}boundingbox'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
    );
  }

  @override
  $HistoryTable createAlias(String alias) {
    return $HistoryTable(attachedDatabase, alias);
  }
}

class HistoryData extends DataClass implements Insertable<HistoryData> {
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final String lat;
  final String lon;
  final String className;
  final String type;
  final int placeRank;
  final double importance;
  final String addresstype;
  final String name;
  final String displayName;
  final String boundingbox;
  final String address;
  const HistoryData({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.className,
    required this.type,
    required this.placeRank,
    required this.importance,
    required this.addresstype,
    required this.name,
    required this.displayName,
    required this.boundingbox,
    required this.address,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['place_id'] = Variable<int>(placeId);
    map['licence'] = Variable<String>(licence);
    map['osm_type'] = Variable<String>(osmType);
    map['osm_id'] = Variable<int>(osmId);
    map['lat'] = Variable<String>(lat);
    map['lon'] = Variable<String>(lon);
    map['class'] = Variable<String>(className);
    map['type'] = Variable<String>(type);
    map['place_rank'] = Variable<int>(placeRank);
    map['importance'] = Variable<double>(importance);
    map['addresstype'] = Variable<String>(addresstype);
    map['name'] = Variable<String>(name);
    map['display_name'] = Variable<String>(displayName);
    map['boundingbox'] = Variable<String>(boundingbox);
    map['address'] = Variable<String>(address);
    return map;
  }

  HistoryCompanion toCompanion(bool nullToAbsent) {
    return HistoryCompanion(
      placeId: Value(placeId),
      licence: Value(licence),
      osmType: Value(osmType),
      osmId: Value(osmId),
      lat: Value(lat),
      lon: Value(lon),
      className: Value(className),
      type: Value(type),
      placeRank: Value(placeRank),
      importance: Value(importance),
      addresstype: Value(addresstype),
      name: Value(name),
      displayName: Value(displayName),
      boundingbox: Value(boundingbox),
      address: Value(address),
    );
  }

  factory HistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryData(
      placeId: serializer.fromJson<int>(json['placeId']),
      licence: serializer.fromJson<String>(json['licence']),
      osmType: serializer.fromJson<String>(json['osmType']),
      osmId: serializer.fromJson<int>(json['osmId']),
      lat: serializer.fromJson<String>(json['lat']),
      lon: serializer.fromJson<String>(json['lon']),
      className: serializer.fromJson<String>(json['className']),
      type: serializer.fromJson<String>(json['type']),
      placeRank: serializer.fromJson<int>(json['placeRank']),
      importance: serializer.fromJson<double>(json['importance']),
      addresstype: serializer.fromJson<String>(json['addresstype']),
      name: serializer.fromJson<String>(json['name']),
      displayName: serializer.fromJson<String>(json['displayName']),
      boundingbox: serializer.fromJson<String>(json['boundingbox']),
      address: serializer.fromJson<String>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'placeId': serializer.toJson<int>(placeId),
      'licence': serializer.toJson<String>(licence),
      'osmType': serializer.toJson<String>(osmType),
      'osmId': serializer.toJson<int>(osmId),
      'lat': serializer.toJson<String>(lat),
      'lon': serializer.toJson<String>(lon),
      'className': serializer.toJson<String>(className),
      'type': serializer.toJson<String>(type),
      'placeRank': serializer.toJson<int>(placeRank),
      'importance': serializer.toJson<double>(importance),
      'addresstype': serializer.toJson<String>(addresstype),
      'name': serializer.toJson<String>(name),
      'displayName': serializer.toJson<String>(displayName),
      'boundingbox': serializer.toJson<String>(boundingbox),
      'address': serializer.toJson<String>(address),
    };
  }

  HistoryData copyWith({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    String? lat,
    String? lon,
    String? className,
    String? type,
    int? placeRank,
    double? importance,
    String? addresstype,
    String? name,
    String? displayName,
    String? boundingbox,
    String? address,
  }) => HistoryData(
    placeId: placeId ?? this.placeId,
    licence: licence ?? this.licence,
    osmType: osmType ?? this.osmType,
    osmId: osmId ?? this.osmId,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    className: className ?? this.className,
    type: type ?? this.type,
    placeRank: placeRank ?? this.placeRank,
    importance: importance ?? this.importance,
    addresstype: addresstype ?? this.addresstype,
    name: name ?? this.name,
    displayName: displayName ?? this.displayName,
    boundingbox: boundingbox ?? this.boundingbox,
    address: address ?? this.address,
  );
  HistoryData copyWithCompanion(HistoryCompanion data) {
    return HistoryData(
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      licence: data.licence.present ? data.licence.value : this.licence,
      osmType: data.osmType.present ? data.osmType.value : this.osmType,
      osmId: data.osmId.present ? data.osmId.value : this.osmId,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      className: data.className.present ? data.className.value : this.className,
      type: data.type.present ? data.type.value : this.type,
      placeRank: data.placeRank.present ? data.placeRank.value : this.placeRank,
      importance: data.importance.present
          ? data.importance.value
          : this.importance,
      addresstype: data.addresstype.present
          ? data.addresstype.value
          : this.addresstype,
      name: data.name.present ? data.name.value : this.name,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      boundingbox: data.boundingbox.present
          ? data.boundingbox.value
          : this.boundingbox,
      address: data.address.present ? data.address.value : this.address,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryData(')
          ..write('placeId: $placeId, ')
          ..write('licence: $licence, ')
          ..write('osmType: $osmType, ')
          ..write('osmId: $osmId, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('className: $className, ')
          ..write('type: $type, ')
          ..write('placeRank: $placeRank, ')
          ..write('importance: $importance, ')
          ..write('addresstype: $addresstype, ')
          ..write('name: $name, ')
          ..write('displayName: $displayName, ')
          ..write('boundingbox: $boundingbox, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    placeId,
    licence,
    osmType,
    osmId,
    lat,
    lon,
    className,
    type,
    placeRank,
    importance,
    addresstype,
    name,
    displayName,
    boundingbox,
    address,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryData &&
          other.placeId == this.placeId &&
          other.licence == this.licence &&
          other.osmType == this.osmType &&
          other.osmId == this.osmId &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.className == this.className &&
          other.type == this.type &&
          other.placeRank == this.placeRank &&
          other.importance == this.importance &&
          other.addresstype == this.addresstype &&
          other.name == this.name &&
          other.displayName == this.displayName &&
          other.boundingbox == this.boundingbox &&
          other.address == this.address);
}

class HistoryCompanion extends UpdateCompanion<HistoryData> {
  final Value<int> placeId;
  final Value<String> licence;
  final Value<String> osmType;
  final Value<int> osmId;
  final Value<String> lat;
  final Value<String> lon;
  final Value<String> className;
  final Value<String> type;
  final Value<int> placeRank;
  final Value<double> importance;
  final Value<String> addresstype;
  final Value<String> name;
  final Value<String> displayName;
  final Value<String> boundingbox;
  final Value<String> address;
  const HistoryCompanion({
    this.placeId = const Value.absent(),
    this.licence = const Value.absent(),
    this.osmType = const Value.absent(),
    this.osmId = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.className = const Value.absent(),
    this.type = const Value.absent(),
    this.placeRank = const Value.absent(),
    this.importance = const Value.absent(),
    this.addresstype = const Value.absent(),
    this.name = const Value.absent(),
    this.displayName = const Value.absent(),
    this.boundingbox = const Value.absent(),
    this.address = const Value.absent(),
  });
  HistoryCompanion.insert({
    this.placeId = const Value.absent(),
    required String licence,
    required String osmType,
    required int osmId,
    required String lat,
    required String lon,
    required String className,
    required String type,
    required int placeRank,
    required double importance,
    required String addresstype,
    required String name,
    required String displayName,
    required String boundingbox,
    required String address,
  }) : licence = Value(licence),
       osmType = Value(osmType),
       osmId = Value(osmId),
       lat = Value(lat),
       lon = Value(lon),
       className = Value(className),
       type = Value(type),
       placeRank = Value(placeRank),
       importance = Value(importance),
       addresstype = Value(addresstype),
       name = Value(name),
       displayName = Value(displayName),
       boundingbox = Value(boundingbox),
       address = Value(address);
  static Insertable<HistoryData> custom({
    Expression<int>? placeId,
    Expression<String>? licence,
    Expression<String>? osmType,
    Expression<int>? osmId,
    Expression<String>? lat,
    Expression<String>? lon,
    Expression<String>? className,
    Expression<String>? type,
    Expression<int>? placeRank,
    Expression<double>? importance,
    Expression<String>? addresstype,
    Expression<String>? name,
    Expression<String>? displayName,
    Expression<String>? boundingbox,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (placeId != null) 'place_id': placeId,
      if (licence != null) 'licence': licence,
      if (osmType != null) 'osm_type': osmType,
      if (osmId != null) 'osm_id': osmId,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (className != null) 'class': className,
      if (type != null) 'type': type,
      if (placeRank != null) 'place_rank': placeRank,
      if (importance != null) 'importance': importance,
      if (addresstype != null) 'addresstype': addresstype,
      if (name != null) 'name': name,
      if (displayName != null) 'display_name': displayName,
      if (boundingbox != null) 'boundingbox': boundingbox,
      if (address != null) 'address': address,
    });
  }

  HistoryCompanion copyWith({
    Value<int>? placeId,
    Value<String>? licence,
    Value<String>? osmType,
    Value<int>? osmId,
    Value<String>? lat,
    Value<String>? lon,
    Value<String>? className,
    Value<String>? type,
    Value<int>? placeRank,
    Value<double>? importance,
    Value<String>? addresstype,
    Value<String>? name,
    Value<String>? displayName,
    Value<String>? boundingbox,
    Value<String>? address,
  }) {
    return HistoryCompanion(
      placeId: placeId ?? this.placeId,
      licence: licence ?? this.licence,
      osmType: osmType ?? this.osmType,
      osmId: osmId ?? this.osmId,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      className: className ?? this.className,
      type: type ?? this.type,
      placeRank: placeRank ?? this.placeRank,
      importance: importance ?? this.importance,
      addresstype: addresstype ?? this.addresstype,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      boundingbox: boundingbox ?? this.boundingbox,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (licence.present) {
      map['licence'] = Variable<String>(licence.value);
    }
    if (osmType.present) {
      map['osm_type'] = Variable<String>(osmType.value);
    }
    if (osmId.present) {
      map['osm_id'] = Variable<int>(osmId.value);
    }
    if (lat.present) {
      map['lat'] = Variable<String>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<String>(lon.value);
    }
    if (className.present) {
      map['class'] = Variable<String>(className.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (placeRank.present) {
      map['place_rank'] = Variable<int>(placeRank.value);
    }
    if (importance.present) {
      map['importance'] = Variable<double>(importance.value);
    }
    if (addresstype.present) {
      map['addresstype'] = Variable<String>(addresstype.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (boundingbox.present) {
      map['boundingbox'] = Variable<String>(boundingbox.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryCompanion(')
          ..write('placeId: $placeId, ')
          ..write('licence: $licence, ')
          ..write('osmType: $osmType, ')
          ..write('osmId: $osmId, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('className: $className, ')
          ..write('type: $type, ')
          ..write('placeRank: $placeRank, ')
          ..write('importance: $importance, ')
          ..write('addresstype: $addresstype, ')
          ..write('name: $name, ')
          ..write('displayName: $displayName, ')
          ..write('boundingbox: $boundingbox, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

abstract class _$HistoryDatabase extends GeneratedDatabase {
  _$HistoryDatabase(QueryExecutor e) : super(e);
  $HistoryDatabaseManager get managers => $HistoryDatabaseManager(this);
  late final $HistoryTable history = $HistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [history];
}

typedef $$HistoryTableCreateCompanionBuilder =
    HistoryCompanion Function({
      Value<int> placeId,
      required String licence,
      required String osmType,
      required int osmId,
      required String lat,
      required String lon,
      required String className,
      required String type,
      required int placeRank,
      required double importance,
      required String addresstype,
      required String name,
      required String displayName,
      required String boundingbox,
      required String address,
    });
typedef $$HistoryTableUpdateCompanionBuilder =
    HistoryCompanion Function({
      Value<int> placeId,
      Value<String> licence,
      Value<String> osmType,
      Value<int> osmId,
      Value<String> lat,
      Value<String> lon,
      Value<String> className,
      Value<String> type,
      Value<int> placeRank,
      Value<double> importance,
      Value<String> addresstype,
      Value<String> name,
      Value<String> displayName,
      Value<String> boundingbox,
      Value<String> address,
    });

class $$HistoryTableFilterComposer
    extends Composer<_$HistoryDatabase, $HistoryTable> {
  $$HistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licence => $composableBuilder(
    column: $table.licence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get osmType => $composableBuilder(
    column: $table.osmType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get osmId => $composableBuilder(
    column: $table.osmId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get placeRank => $composableBuilder(
    column: $table.placeRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addresstype => $composableBuilder(
    column: $table.addresstype,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boundingbox => $composableBuilder(
    column: $table.boundingbox,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HistoryTableOrderingComposer
    extends Composer<_$HistoryDatabase, $HistoryTable> {
  $$HistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licence => $composableBuilder(
    column: $table.licence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get osmType => $composableBuilder(
    column: $table.osmType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get osmId => $composableBuilder(
    column: $table.osmId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get placeRank => $composableBuilder(
    column: $table.placeRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addresstype => $composableBuilder(
    column: $table.addresstype,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boundingbox => $composableBuilder(
    column: $table.boundingbox,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HistoryTableAnnotationComposer
    extends Composer<_$HistoryDatabase, $HistoryTable> {
  $$HistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get placeId =>
      $composableBuilder(column: $table.placeId, builder: (column) => column);

  GeneratedColumn<String> get licence =>
      $composableBuilder(column: $table.licence, builder: (column) => column);

  GeneratedColumn<String> get osmType =>
      $composableBuilder(column: $table.osmType, builder: (column) => column);

  GeneratedColumn<int> get osmId =>
      $composableBuilder(column: $table.osmId, builder: (column) => column);

  GeneratedColumn<String> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<String> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get placeRank =>
      $composableBuilder(column: $table.placeRank, builder: (column) => column);

  GeneratedColumn<double> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addresstype => $composableBuilder(
    column: $table.addresstype,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get boundingbox => $composableBuilder(
    column: $table.boundingbox,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);
}

class $$HistoryTableTableManager
    extends
        RootTableManager<
          _$HistoryDatabase,
          $HistoryTable,
          HistoryData,
          $$HistoryTableFilterComposer,
          $$HistoryTableOrderingComposer,
          $$HistoryTableAnnotationComposer,
          $$HistoryTableCreateCompanionBuilder,
          $$HistoryTableUpdateCompanionBuilder,
          (
            HistoryData,
            BaseReferences<_$HistoryDatabase, $HistoryTable, HistoryData>,
          ),
          HistoryData,
          PrefetchHooks Function()
        > {
  $$HistoryTableTableManager(_$HistoryDatabase db, $HistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> placeId = const Value.absent(),
                Value<String> licence = const Value.absent(),
                Value<String> osmType = const Value.absent(),
                Value<int> osmId = const Value.absent(),
                Value<String> lat = const Value.absent(),
                Value<String> lon = const Value.absent(),
                Value<String> className = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> placeRank = const Value.absent(),
                Value<double> importance = const Value.absent(),
                Value<String> addresstype = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> boundingbox = const Value.absent(),
                Value<String> address = const Value.absent(),
              }) => HistoryCompanion(
                placeId: placeId,
                licence: licence,
                osmType: osmType,
                osmId: osmId,
                lat: lat,
                lon: lon,
                className: className,
                type: type,
                placeRank: placeRank,
                importance: importance,
                addresstype: addresstype,
                name: name,
                displayName: displayName,
                boundingbox: boundingbox,
                address: address,
              ),
          createCompanionCallback:
              ({
                Value<int> placeId = const Value.absent(),
                required String licence,
                required String osmType,
                required int osmId,
                required String lat,
                required String lon,
                required String className,
                required String type,
                required int placeRank,
                required double importance,
                required String addresstype,
                required String name,
                required String displayName,
                required String boundingbox,
                required String address,
              }) => HistoryCompanion.insert(
                placeId: placeId,
                licence: licence,
                osmType: osmType,
                osmId: osmId,
                lat: lat,
                lon: lon,
                className: className,
                type: type,
                placeRank: placeRank,
                importance: importance,
                addresstype: addresstype,
                name: name,
                displayName: displayName,
                boundingbox: boundingbox,
                address: address,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$HistoryDatabase,
      $HistoryTable,
      HistoryData,
      $$HistoryTableFilterComposer,
      $$HistoryTableOrderingComposer,
      $$HistoryTableAnnotationComposer,
      $$HistoryTableCreateCompanionBuilder,
      $$HistoryTableUpdateCompanionBuilder,
      (
        HistoryData,
        BaseReferences<_$HistoryDatabase, $HistoryTable, HistoryData>,
      ),
      HistoryData,
      PrefetchHooks Function()
    >;

class $HistoryDatabaseManager {
  final _$HistoryDatabase _db;
  $HistoryDatabaseManager(this._db);
  $$HistoryTableTableManager get history =>
      $$HistoryTableTableManager(_db, _db.history);
}
