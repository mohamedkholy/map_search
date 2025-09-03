import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/core/helpers.dart/connection_observer.dart';
import 'package:map_search/core/helpers.dart/current_location_sp.dart';
import 'package:map_search/core/networking/api_service.dart';
import 'package:map_search/features/map/data/models/location_error.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/map/data/repos/map_repo.dart';
import 'package:map_search/features/map/logic/map_state.dart';

class MapCubit extends Cubit<MapState> {
  final apiService = ApiService();
  final _mapRepo = MapRepo();
  MapCubit() : super(MapInitial());

  void search(String query) async {
    try {
      final places = await apiService.searchPlaces(query);
      emit(SearchReslutsLoaded(places: places));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  LatLng getSavedLocation() {
    final location = CurrentLocationSP.geteLocationFromSP();
    if (location == null) {
      return const LatLng(0, 0);
    }
    emit(LocationLoaded(location: location));
    return location;
  }

  void updateLocation(LatLng location) {
    emit(LocationLoaded(location: location));
  }

  Future<void> checkLocationStatus(LatLng savedLocation) async {
    await Future.delayed(const Duration(milliseconds: 300));
    emit(FetchingLocation());
    if (await ConnectionObserver.checkConnectivity() ==
        InternetConnectionState.disconnected) {
      emit(
        LocationErrorState(
          message: 'No internet connection',
          errorType: LocationError.noInternet,
        ),
      );
      return;
    }
    if (await Geolocator.isLocationServiceEnabled()) {
      Geolocator.requestPermission().then((status) async {
        if (status == LocationPermission.always ||
            status == LocationPermission.whileInUse) {
          final position = await Geolocator.getCurrentPosition();
          CurrentLocationSP.saveLocationToSP(
            LatLng(position.latitude, position.longitude),
          );
          if (savedLocation == LatLng(position.latitude, position.longitude)) {
            emit(MapInitial());
            return;
          }
          emit(
            LocationLoaded(
              location: LatLng(position.latitude, position.longitude),
            ),
          );
        } else if (status == LocationPermission.deniedForever) {
          emit(
            LocationErrorState(
              message: 'You need to allow location permission from settings',
              errorType: LocationError.locationDenied,
              openSettings: true,
            ),
          );
        } else if (status == LocationPermission.denied) {
          emit(
            LocationErrorState(
              message:
                  'To get your current location you must accept the location permission',
              errorType: LocationError.locationDenied,
            ),
          );
        }
      });
    } else {
      emit(
        LocationErrorState(
          message: 'Location service is disabled',
          errorType: LocationError.locationDenied,
        ),
      );
    }
  }

  Future<void> fetchRouteFromOSRM(LatLng latLng, Place place) async {
    emit(FetchingRoute());
    final route = await apiService.fetchRouteFromOSRM(
      latLng,
      LatLng(double.parse(place.lat), double.parse(place.lon)),
    );
    emit(ResultChosenState(place: place, route: route));
  }

  Future<void> addPlaceToHistory(Place place) async {
    await _mapRepo.addPlaceToHistory(place);
  }

  Future<List<Place>> getHistory() async {
    emit(HistoryLoaded(history: await _mapRepo.getHistory()));
    return await _mapRepo.getHistory();
  }

  Future<void> deletePlaceFromHistory(Place place) async {
    await _mapRepo.deletePlaceFromHistory(place);
  }
}
