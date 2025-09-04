import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class LocationUpdated extends NavigationState {
  final Position position;
  final List<LatLng> route;
  final double markerRotation;
  LocationUpdated({required this.position, required this.route, required this.markerRotation});
}

class DestinationReached extends NavigationState {}
