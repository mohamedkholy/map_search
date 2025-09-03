import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class DistanceCalculator {
  static double distanceToPoint(LatLng currentLocation, LatLng pointLatLng) {
    final distance =
        Geolocator.distanceBetween(
          currentLocation.latitude,
          currentLocation.longitude,
          pointLatLng.latitude,
          pointLatLng.longitude,
        ) /
        1000;
    return distance;
  }

  static double calculateRouteDistance(List<LatLng> route) {
    double totalDistance = 0.0;

    for (int i = 0; i < route.length - 1; i++) {
      totalDistance += Geolocator.distanceBetween(
        route[i].latitude,
        route[i].longitude,
        route[i + 1].latitude,
        route[i + 1].longitude,
      );
    }

    return totalDistance / 1000;
  }

  static LatLngBounds getBounds(LatLng mosqueLocation, LatLng currentLocation) {
    final double minLat = min(
      mosqueLocation.latitude,
      currentLocation.latitude,
    );
    final double maxLat = max(
      mosqueLocation.latitude,
      currentLocation.latitude,
    );
    final double minLng = min(
      mosqueLocation.longitude,
      currentLocation.longitude,
    );
    final double maxLng = max(
      mosqueLocation.longitude,
      currentLocation.longitude,
    );

    const buffer = 0.009;
    final southwest = LatLng(minLat - buffer, minLng - buffer);
    final northeast = LatLng(maxLat + buffer, maxLng + buffer);

    return LatLngBounds(southwest, northeast);
  }
}
