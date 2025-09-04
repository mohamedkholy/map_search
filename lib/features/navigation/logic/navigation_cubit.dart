import 'dart:async';
import 'dart:math';

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
  late LatLng currentLocation;
  List<LatLng>? currentRoute;
  final Distance _distance = const Distance();

  void trackLocation(Place place, LatLng startLocation, List<LatLng> route) {
    final destinationLocation = LatLng(
      double.parse(place.lat),
      double.parse(place.lon),
    );
    currentLocation = startLocation;
    currentRoute = route;
    _positionStreamSubscription =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            intervalDuration: const Duration(milliseconds: 500),
          ),
        ).listen((position) async {
          if (!isClosed &&
              currentLocation !=
                  LatLng(position.latitude, position.longitude)) {
            currentLocation = LatLng(position.latitude, position.longitude);
            if (_distance.distance(currentLocation, destinationLocation) < 50) {
              emit(DestinationReached());
              await dispose();
              return;
            }
            CurrentLocationSP.saveLocationToSP(currentLocation);
            if (currentRoute != null) {
              currentRoute = snapToRoute(currentLocation, currentRoute!);
              currentRoute ??= await apiService.fetchRouteFromOSRM(
                currentLocation,
                LatLng(double.parse(place.lat), double.parse(place.lon)),
              );
              if (currentRoute!.length > 1) {
                final rotation = calculateRotation(
                  currentRoute![0],
                  currentRoute![1],
                );

                emit(
                  LocationUpdated(
                    position: position,
                    route: currentRoute!,
                    markerRotation: rotation,
                  ),
                );
              }
            }
          }
        });
  }

  Future<void> dispose() async {
    await _positionStreamSubscription.cancel();
  }

  (LatLng?, bool) _projectPointOnSegment(LatLng a, LatLng b, LatLng p) {
    final ax = a.latitude;
    final ay = a.longitude;
    final bx = b.latitude;
    final by = b.longitude;
    final px = p.latitude;
    final py = p.longitude;

    final abx = bx - ax;
    final aby = by - ay;
    final apx = px - ax;
    final apy = py - ay;

    final ab2 = abx * abx + aby * aby;

    if (ab2 == 0.0) return (null, false);

    final apAb = apx * abx + apy * aby;
    double t = apAb / ab2;

    if (t < 0.0) t = 0.0;
    if (t > 1.0) t = 1.0;

    final newPoint = LatLng(ax + abx * t, ay + aby * t);

    return (newPoint, t > 0.0 && t < 1.0);
  }

  List<LatLng>? snapToRoute(LatLng current, List<LatLng> route) {
    int bestSegmentIndex = -1;
    LatLng? bestPoint;

    for (
      int i = 0;
      i < route.sublist(0, min(route.length, 20)).length - 1;
      i++
    ) {
      final a = route[i];
      final b = route[i + 1];

      if (a == b) continue;

      final (q, isInside) = _projectPointOnSegment(a, b, current);
      if (isInside) {
        bestSegmentIndex = i;
        bestPoint = q;
        break;
      }
    }

    if (bestPoint == null) return null;

    if (_distance.distance(current, bestPoint) > 10) {
      return null;
    }

    final remaining = <LatLng>[];
    remaining.add(bestPoint);
    remaining.addAll(route.sublist(bestSegmentIndex + 1));

    return remaining;
  }

  double calculateRotation(LatLng bestPoint, LatLng nextPoint) {
    final y1 = bestPoint.longitude;
    final x1 = bestPoint.latitude;
    final y2 = nextPoint.longitude;
    final x2 = nextPoint.latitude;
    return atan2(y2 - y1, x2 - x1);
  }
}
