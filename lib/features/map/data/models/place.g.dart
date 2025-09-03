// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
  placeId: (json['place_id'] as num).toInt(),
  licence: json['licence'] as String,
  osmType: json['osm_type'] as String,
  osmId: (json['osm_id'] as num).toInt(),
  lat: json['lat'] as String,
  lon: json['lon'] as String,
  className: json['class'] as String,
  type: json['type'] as String,
  placeRank: (json['place_rank'] as num).toInt(),
  importance: (json['importance'] as num).toDouble(),
  addresstype: json['addresstype'] as String,
  name: json['name'] as String,
  displayName: json['display_name'] as String,
  boundingbox: (json['boundingbox'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
  'place_id': instance.placeId,
  'licence': instance.licence,
  'osm_type': instance.osmType,
  'osm_id': instance.osmId,
  'lat': instance.lat,
  'lon': instance.lon,
  'class': instance.className,
  'type': instance.type,
  'place_rank': instance.placeRank,
  'importance': instance.importance,
  'addresstype': instance.addresstype,
  'name': instance.name,
  'display_name': instance.displayName,
  'boundingbox': instance.boundingbox,
};
