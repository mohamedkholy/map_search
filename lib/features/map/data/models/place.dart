import 'package:json_annotation/json_annotation.dart';
import 'package:map_search/core/database/history_database.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  @JsonKey(name: "place_id")
  int placeId;
  String licence;
  @JsonKey(name: "osm_type")
  String osmType;
  @JsonKey(name: "osm_id")
  int osmId;
  String lat;
  String lon;
  @JsonKey(name: "class")
  String className;
  String type;
  @JsonKey(name: "place_rank")
  int placeRank;
  double importance;
  String addresstype;
  String name;
  @JsonKey(name: "display_name")
  String displayName;
  List<String> boundingbox;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? address;

  Place({
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
    this.address,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  @override
  int get hashCode =>
      placeId.hashCode |
      osmId.hashCode |
      placeRank.hashCode |
      importance.hashCode |
      addresstype.hashCode |
      name.hashCode |
      displayName.hashCode |
      boundingbox.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.placeId == placeId &&
        other.licence == licence &&
        other.osmType == osmType &&
        other.osmId == osmId &&
        other.lat == lat &&
        other.lon == lon &&
        other.className == className &&
        other.type == type &&
        other.placeRank == placeRank &&
        other.importance == importance &&
        other.addresstype == addresstype &&
        other.name == name &&
        other.displayName == displayName &&
        other.boundingbox == boundingbox;
  }

  @override
  String toString() {
    return 'Place(placeId: $placeId, licence: $licence, osmType: $osmType, osmId: $osmId, lat: $lat, lon: $lon, className: $className, type: $type, placeRank: $placeRank, importance: $importance, addresstype: $addresstype, name: $name, displayName: $displayName, boundingbox: $boundingbox, address: $address)';
  }
}

extension PlaceMapper on Place {
  HistoryData toCompanion() {
    return HistoryData(
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
      boundingbox: boundingbox.join(","),
      address: address ?? displayName,
    );
  }
}

extension PlaceDataMapper on Place {
  static Place fromData(HistoryData data) {
    return Place(
      placeId: data.placeId,
      licence: data.licence,
      osmType: data.osmType,
      osmId: data.osmId,
      lat: data.lat,
      lon: data.lon,
      className: data.className,
      type: data.type,
      placeRank: data.placeRank,
      importance: data.importance,
      addresstype: data.addresstype,
      name: data.name,
      displayName: data.displayName,
      boundingbox: data.boundingbox.split(","),
      address: data.address,
    );
  }
}
