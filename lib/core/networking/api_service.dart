import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/core/networking/orsm_response.dart';

class ApiService {
  final dio = Dio()
    ..options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

  static String getOsrmApiUrl(String pathParams) =>
      'https://router.project-osrm.org/route/v1/driving/$pathParams?overview=full&geometries=geojson';

  Future<List<Place>> searchPlaces(String query) async {
    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json';

    final result = await dio.get(
      url,
      options: Options(headers: {"User-Agent": "com.dev3mk.map_search/1.0"}),
    );
    final List<dynamic> data = result.data;
    final List<Place> places = data.map((p) => Place.fromJson(p)).toList();
    await Future.wait(
      places.map((place) async {
        place.address =
            await getAddressFromLocation(
              LatLng(double.parse(place.lat), double.parse(place.lon)),
            ) ??
            place.displayName;
      }),
    );

    return places;
  }

  Future<String?> getAddressFromLocation(LatLng location) async {
    final place = (await GeocodingPlatform.instance?.placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    ))?.first;
    return place != null
        ? [
            place.street,
            place.locality,
            place.administrativeArea,
            place.country,
          ].where((e) => e != null && e.isNotEmpty).join(", ")
        : null;
  }

  Future<List<LatLng>> fetchRouteFromOSRM(
    LatLng origin,
    LatLng destination,
  ) async {
    final pathParams =
        "${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}";
    final osrmApiUrl = getOsrmApiUrl(pathParams);
    final response = await dio.get(osrmApiUrl);
    if (response.statusCode != 200) return [];
    final OrsmResponse orsmResponse = OrsmResponse.fromJson(response.data);
    if (orsmResponse.routes.isEmpty) return [];
    final coords = orsmResponse.routes.first.geometry.coordinates;
    return coords.map((c) => LatLng(c[1].toDouble(), c[0].toDouble())).toList();
  }
}
