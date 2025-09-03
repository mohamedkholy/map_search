import 'package:json_annotation/json_annotation.dart';

part 'orsm_response.g.dart';

@JsonSerializable()
class OrsmResponse {
  final String code;
  final List<RouteModel> routes;
  final List<Waypoint> waypoints;

  OrsmResponse({
    required this.code,
    required this.routes,
    required this.waypoints,
  });

  factory OrsmResponse.fromJson(Map<String, dynamic> json) =>
      _$OrsmResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrsmResponseToJson(this);
}

@JsonSerializable()
class RouteModel {
  final List<Leg> legs;
  @JsonKey(name: 'weight_name')
  final String weightName;
  final Geometry geometry;
  final double weight;
  final double duration;
  final double distance;

  RouteModel({
    required this.legs,
    required this.weightName,
    required this.geometry,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);
  Map<String, dynamic> toJson() => _$RouteModelToJson(this);
}

@JsonSerializable()
class Geometry {
  final List<List<double>> coordinates;
  final String type;

  Geometry({required this.coordinates, required this.type});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Leg {
  final List<dynamic> steps;
  final double weight;
  final String summary;
  final double duration;
  final double distance;

  Leg({
    required this.steps,
    required this.weight,
    required this.summary,
    required this.duration,
    required this.distance,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);
  Map<String, dynamic> toJson() => _$LegToJson(this);
}

@JsonSerializable()
class Waypoint {
  final String hint;
  final List<double> location;
  final String name;
  final double distance;

  Waypoint({
    required this.hint,
    required this.location,
    required this.name,
    required this.distance,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);
  Map<String, dynamic> toJson() => _$WaypointToJson(this);
}
