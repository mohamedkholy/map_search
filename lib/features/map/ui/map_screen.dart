import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/core/helpers.dart/distance_calculator.dart' as dc;
import 'package:map_search/core/theming/my_colors.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/map/logic/map_cubit.dart';
import 'package:map_search/features/map/logic/map_state.dart';
import 'package:map_search/features/map/ui/history_screen.dart';
import 'package:map_search/features/map/ui/widgets/collapesd_error_widget.dart';
import 'package:map_search/features/map/ui/widgets/current_location_button.dart';
import 'package:map_search/features/map/ui/widgets/destination_reached_widget.dart';
import 'package:map_search/features/map/ui/widgets/error_state_widget.dart';
import 'package:map_search/features/map/ui/widgets/route_details_widget.dart';
import 'package:map_search/features/map/ui/widgets/search_field.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng currentLocation;
  ValueNotifier<bool> isLocationDeniedExpanded = ValueNotifier(false);
  final MapController mapController = MapController();
  bool isMapReady = false;
  late final MapCubit _mapCubit = context.read();
  List<Marker> markers = [];
  List<LatLng>? route;
  Marker? _selectedPlaceMarker;

  @override
  void initState() {
    currentLocation = _mapCubit.getSavedLocation();
    _mapCubit.checkLocationStatus(currentLocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        centerTitle: true,
        title: const Text('Map Search'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white, size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: _mapCubit,
                    child: HistoryScreen(currentLocation: currentLocation),
                  ),
                ),
              ).then((value) {
                if (currentLocation != const LatLng(0, 0) && value != null) {
                  _mapCubit.fetchRouteFromOSRM(currentLocation, value as Place);
                }
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  BlocConsumer<MapCubit, MapState>(
                    listener: (context, state) {
                      if (state is FetchingRoute) {
                        showDialog(
                          context: context,
                          builder: (context) => const PopScope(
                            canPop: false,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is ResultChosenState) {
                        Navigator.pop(context);
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is LocationLoaded ||
                        current is ResultChosenState,
                    builder: (context, state) {
                      if (state is LocationLoaded) {
                        currentLocation = state.location;
                        markers.clear();
                        route = null;
                      }
                      if (currentLocation != const LatLng(0, 0)) {
                        markers.add(
                          Marker(
                            point: currentLocation,
                            child: Image.asset(
                              "assets/images/current_location.png",
                              color: MyColors.primary,
                              width: 15,
                              height: 15,
                            ),
                          ),
                        );
                        animateCameraToCurrentLocation();
                      }
                      if (state is ResultChosenState) {
                        if (_selectedPlaceMarker != null) {
                          markers.remove(_selectedPlaceMarker!);
                        }
                        _selectedPlaceMarker = Marker(
                          point: LatLng(
                            double.parse(state.place.lat),
                            double.parse(state.place.lon),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 25,
                          ),
                        );
                        markers.add(_selectedPlaceMarker!);
                        route = state.route;

                        if (isMapReady) {
                          mapController.fitCamera(
                            CameraFit.bounds(
                              bounds: dc.DistanceCalculator.getBounds(
                                LatLng(
                                  double.parse(state.place.lat),
                                  double.parse(state.place.lon),
                                ),
                                currentLocation,
                              ),
                            ),
                          );
                        }
                      }
                      return FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          onMapReady: () {
                            isMapReady = true;
                            if (currentLocation != const LatLng(0, 0)) {
                              animateCameraToCurrentLocation();
                            }
                          },
                          initialCenter: currentLocation,
                          initialZoom: currentLocation == const LatLng(0, 0)
                              ? 2
                              : 16,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.dev3mk.map_search',
                          ),
                          if (route != null)
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: route!,
                                  color: Colors.blue,
                                  strokeWidth: 2,
                                ),
                              ],
                            ),
                          MarkerLayer(markers: markers),
                        ],
                      );
                    },
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BlocBuilder<MapCubit, MapState>(
                            buildWhen: (previous, current) =>
                                current is MapInitial ||
                                current is FetchingLocation ||
                                current is LocationLoaded ||
                                current is LocationErrorState,
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: state is FetchingLocation
                                    ? null
                                    : () {
                                        animateCameraToCurrentLocation();
                                      },
                                child: CurrentLocationButton(
                                  isLoading: state is FetchingLocation,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<MapCubit, MapState>(
                    buildWhen: (previous, current) => current is LocationLoaded,
                    builder: (context, state) {
                      if (state is LocationLoaded) {
                        return SearchField(currentLocation: state.location);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  BlocBuilder<MapCubit, MapState>(
                    buildWhen: (previous, current) =>
                        current is LocationErrorState ||
                        current is FetchingLocation,
                    builder: (context, state) {
                      if (state is LocationErrorState) {
                        isLocationDeniedExpanded.value = true;
                        return ValueListenableBuilder(
                          valueListenable: isLocationDeniedExpanded,
                          builder: (context, value, child) {
                            return value
                                ? ErrorStateWidget(
                                    errorMessage: state.message,
                                    onArrowClick: () {
                                      isLocationDeniedExpanded.value = false;
                                    },
                                    callback: () {
                                      _mapCubit.checkLocationStatus(
                                        currentLocation,
                                      );
                                    },
                                    errorType: state.errorType,
                                    openSettings: state.openSettings,
                                  )
                                : CollapesdErrorWidget(
                                    isLocationDeniedExpanded:
                                        isLocationDeniedExpanded,
                                    errorType: state.errorType,
                                    message: state.message,
                                  );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  BlocBuilder<MapCubit, MapState>(
                    buildWhen: (previous, current) => current is LocationLoaded,
                    builder: (context, state) {
                      if (state is LocationLoaded && state.place != null) {
                        return DestinationReachedWidget(
                          place: state.place!,
                          location: state.location,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<MapCubit, MapState>(
              buildWhen: (previous, current) =>
                  current is LocationLoaded || current is ResultChosenState,
              builder: (context, state) {
                if (state is ResultChosenState) {
                  return RouteDetailsWidget(
                    place: state.place,
                    currentLocation: currentLocation,
                    route: state.route,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  void animateCameraToCurrentLocation() {
    if (currentLocation != const LatLng(0, 0) && isMapReady) {
      mapController.moveAndRotate(currentLocation, 16, 0);
    }
  }
}
