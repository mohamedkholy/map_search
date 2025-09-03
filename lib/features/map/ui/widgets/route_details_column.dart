import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/core/helpers.dart/distance_calculator.dart' as dc;
import 'package:map_search/core/theming/my_colors.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/map/logic/map_cubit.dart';
import 'package:map_search/features/map/ui/widgets/distance_widget.dart';
import 'package:map_search/features/navigation/logic/navigation_cubit.dart';
import 'package:map_search/features/navigation/ui/navigation_screen.dart';

class RouteDetailsColumn extends StatelessWidget {
  const RouteDetailsColumn({
    super.key,
    required this.place,
    required this.currentLocation,
    required this.route,
  });

  final Place place;
  final LatLng currentLocation;
  final List<LatLng> route;

  @override
  Widget build(BuildContext context) {
    final distance = dc.DistanceCalculator.distanceToPoint(
      currentLocation,
      LatLng(double.parse(place.lat), double.parse(place.lon)),
    );
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    place.address ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.primary,
                  ),
                  child: const Icon(
                    Icons.near_me,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text("${distance.toStringAsFixed(2)} km"),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: DistanceWidget(
                distance: distance,
                title: "Aerial distance",
                icon: Icons.straight,
                margin: const EdgeInsets.symmetric(horizontal: 5),
              ),
            ),
            Expanded(
              child: DistanceWidget(
                distance: dc.DistanceCalculator.calculateRouteDistance(route),
                title: "Road distance",
                icon: Icons.straight,
                margin: const EdgeInsets.symmetric(horizontal: 5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: MyColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  BlocProvider(
                  create: (context) => NavigationCubit(),
                  child: NavigationScreen(
                    currentLocation: currentLocation,
                    place: place,
                    route: route,
                  ),
                ),
              ),
            ).then((value) {
               if(context.mounted){
                context.read<MapCubit>().updateLocation(value);
               }
            },);
          },
          icon: const Icon(Icons.navigation_sharp, size: 25),
          label: const Text(
            "Start navigation",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
