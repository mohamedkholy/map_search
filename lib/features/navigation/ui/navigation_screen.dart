import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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

class _NavigationScreenState extends State<NavigationScreen> {
  final MapController _mapController = MapController();
  late final NavigationCubit _navigationCubit = context.read();
  late LatLng _currentPosition = widget.currentLocation;
  late List<LatLng> _currentRoute = widget.route;

  @override
  void initState() {
    super.initState();
    print(
      "${widget.currentLocation.latitude} ${widget.currentLocation.longitude}",
    );
    print("${widget.place.lat} ${widget.place.lon}");
    _navigationCubit.trackLocation(widget.place, widget.currentLocation);
  }

  @override
  void dispose() {
    _navigationCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, _currentPosition);
        }
      },
      child: Scaffold(
        body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            if (state is LocationUpdated) {
              _currentPosition = LatLng(
                state.position.latitude,
                state.position.longitude,
              );
              _currentRoute = state.route;
              _mapController.move(_currentPosition, 18);
            }
            return FlutterMap(
              options: MapOptions(
                initialCenter: _currentPosition,
                initialZoom: 18,
              ),
              mapController: _mapController,
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.dev3mk.map_search',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition,
                      child: const Icon(Icons.person),
                    ),
                    Marker(
                      point: LatLng(
                        double.parse(widget.place.lat),
                        double.parse(widget.place.lon),
                      ),
                      child: const Icon(Icons.person),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _currentRoute,
                      color: Colors.blue,
                      strokeWidth: 2,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
