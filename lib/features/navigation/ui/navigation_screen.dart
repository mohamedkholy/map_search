import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/core/theming/my_colors.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/navigation/logic/navigation_cubit.dart';
import 'package:map_search/features/navigation/logic/navigation_state.dart';

class NavigationScreen extends StatefulWidget {
  final Place place;
  final LatLng currentLocation;
  final List<LatLng> route;

  const NavigationScreen({
    super.key,
    required this.place,
    required this.currentLocation,
    required this.route,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController =
      AnimatedMapController(vsync: this, curve: Curves.easeInOut);
  late final NavigationCubit _navigationCubit = context.read();
  late LatLng _currentPosition = widget.currentLocation;
  late LatLng _oldPosition = widget.currentLocation;
  late List<LatLng> _currentRoute = widget.route;
  double _currentZoom = 19;
  final ValueNotifier<bool> _movedPositionNotifier = ValueNotifier(false);
  double _markerRotation = 0;

  @override
  void initState() {
    super.initState();
    _navigationCubit.trackLocation(
      widget.place,
      widget.currentLocation,
      widget.route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _navigationCubit.dispose();
          if (context.mounted) {
            Navigator.pop(context, (_currentPosition, null));
          }
        }
      },
      child: Scaffold(
        body: BlocConsumer<NavigationCubit, NavigationState>(
          listener: (context, state) async {
            if (state is DestinationReached) {
              await _navigationCubit.dispose();
              if (context.mounted) {
                Navigator.pop(context, (_currentPosition, widget.place));
              }
            }
          },
          builder: (context, state) {
            if (state is LocationUpdated) {
              _oldPosition = _currentPosition;
              _currentPosition = LatLng(
                state.position.latitude,
                state.position.longitude,
              );
              _currentRoute = state.route;
              if (!_movedPositionNotifier.value) {
                _animatedMapController.animateTo(
                  dest: _currentPosition,
                  zoom: _currentZoom,
                  rotation: 360 - (_markerRotation * 180 / pi),
                );
              }
              _markerRotation = state.markerRotation;
            }
            return SafeArea(
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      onPositionChanged: (MapCamera camera, bool hasGesture) {
                        if (hasGesture) {
                          _currentZoom = camera.zoom;
                          _movedPositionNotifier.value = true;
                        }
                      },

                      initialCenter: _currentPosition,
                      initialZoom: _currentZoom,
                    ),
                    mapController: _animatedMapController.mapController,
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.dev3mk.map_search',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 45,
                            height: 45,
                            point: _currentPosition,
                            child: Transform.rotate(
                              angle: _markerRotation,
                              child: Image.asset('assets/images/car.png'),
                            ),
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              double.parse(widget.place.lat),
                              double.parse(widget.place.lon),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: _currentRoute,
                            color: Colors.blue,
                            strokeWidth: 4,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: _movedPositionNotifier,
                    builder: (context, value, child) {
                      return value
                          ? GestureDetector(
                              onTap: () {
                                _currentZoom = 19;
                                _animatedMapController.animateTo(
                                  dest: _currentPosition,
                                  zoom: _currentZoom,
                                  rotation: 360 - (_markerRotation * 180 / pi),
                                );
                                _movedPositionNotifier.value = false;
                              },
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.navigation_outlined,
                                        color: MyColors.primary,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Re-center",
                                        style: TextStyle(
                                          color: MyColors.primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
