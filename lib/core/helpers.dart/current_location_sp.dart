import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:map_search/main.dart';

class CurrentLocationSP {
  static const locationKey = "location";

  static void saveLocationToSP(LatLng location) async {
    final locationData = {"lat": location.latitude, "lng": location.longitude};
    sp.setString(locationKey, jsonEncode(locationData));
  }

  static LatLng? geteLocationFromSP() {
    final result = sp.getString(locationKey);
    if (result == null) return null;
    final Map<String, dynamic> locationData = jsonDecode(result);
    return LatLng(locationData["lat"]!, locationData["lng"]!);
  }
}
