import 'package:latlong2/latlong.dart';
import 'package:map_search/features/map/data/models/location_error.dart';
import 'package:map_search/features/map/data/models/place.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class SearchReslutsLoaded extends MapState {
  final List<Place> places;
  SearchReslutsLoaded({required this.places});
}

class FetchingLocation extends MapState {}

class FetchingRoute extends MapState {}

class LocationLoaded extends MapState {
  final LatLng location;
  final Place? place;
  LocationLoaded({required this.location, this.place});
}

class HistoryLoaded extends MapState {
  final List<Place> history;
  HistoryLoaded({required this.history});
}

class ResultChosenState extends MapState {
  final Place place;
  final List<LatLng> route;
  ResultChosenState({required this.place, required this.route});
}

class LocationErrorState extends MapState {
  final String message;
  final LocationError errorType;
  bool? openSettings;
  LocationErrorState({
    required this.message,
    required this.errorType,
    this.openSettings,
  });
}
