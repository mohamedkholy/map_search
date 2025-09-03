import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/core/helpers.dart/current_location_sp.dart';
import 'package:map_search/core/networking/api_service.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/navigation/logic/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());
  final apiService = ApiService();

  late final StreamSubscription<Position> _positionStreamSubscription;
  late final LatLng currentLocation;

  void trackLocation(Place place, LatLng startLocation) {
    currentLocation = startLocation;
    _positionStreamSubscription =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            intervalDuration: const Duration(seconds: 2),
          ),
        ).listen((position) async {
          if (!isClosed &&
              currentLocation !=
                  LatLng(position.latitude, position.longitude)) {
            currentLocation = LatLng(position.latitude, position.longitude);
            CurrentLocationSP.saveLocationToSP(
              currentLocation,
            );
            final route = await apiService.fetchRouteFromOSRM(
              currentLocation,
              LatLng(double.parse(place.lat), double.parse(place.lon)),
            );
            emit(LocationUpdated(position: position, route: route));
          }
        });
  }

  void dispose() {
    _positionStreamSubscription.cancel();
  }
}
