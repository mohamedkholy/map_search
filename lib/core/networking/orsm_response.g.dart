// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orsm_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrsmResponse _$OrsmResponseFromJson(Map<String, dynamic> json) => OrsmResponse(
  code: json['code'] as String,
  routes: (json['routes'] as List<dynamic>)
      .map((e) => RouteModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  waypoints: (json['waypoints'] as List<dynamic>)
      .map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrsmResponseToJson(OrsmResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'routes': instance.routes,
      'waypoints': instance.waypoints,
    };

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => RouteModel(
  legs: (json['legs'] as List<dynamic>)
      .map((e) => Leg.fromJson(e as Map<String, dynamic>))
      .toList(),
  weightName: json['weight_name'] as String,
  geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
  weight: (json['weight'] as num).toDouble(),
  duration: (json['duration'] as num).toDouble(),
  distance: (json['distance'] as num).toDouble(),
);

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'legs': instance.legs,
      'weight_name': instance.weightName,
      'geometry': instance.geometry,
      'weight': instance.weight,
      'duration': instance.duration,
      'distance': instance.distance,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
  coordinates: (json['coordinates'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
      )
      .toList(),
  type: json['type'] as String,
);

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
  'coordinates': instance.coordinates,
  'type': instance.type,
};

Leg _$LegFromJson(Map<String, dynamic> json) => Leg(
  steps: json['steps'] as List<dynamic>,
  weight: (json['weight'] as num).toDouble(),
  summary: json['summary'] as String,
  duration: (json['duration'] as num).toDouble(),
  distance: (json['distance'] as num).toDouble(),
);

Map<String, dynamic> _$LegToJson(Leg instance) => <String, dynamic>{
  'steps': instance.steps,
  'weight': instance.weight,
  'summary': instance.summary,
  'duration': instance.duration,
  'distance': instance.distance,
};

Waypoint _$WaypointFromJson(Map<String, dynamic> json) => Waypoint(
  hint: json['hint'] as String,
  location: (json['location'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  name: json['name'] as String,
  distance: (json['distance'] as num).toDouble(),
);

Map<String, dynamic> _$WaypointToJson(Waypoint instance) => <String, dynamic>{
  'hint': instance.hint,
  'location': instance.location,
  'name': instance.name,
  'distance': instance.distance,
};
