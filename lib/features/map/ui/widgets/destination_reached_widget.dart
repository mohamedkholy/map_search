import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/map/logic/map_cubit.dart';

class DestinationReachedWidget extends StatelessWidget {
  final Place place;
  final LatLng location;
  const DestinationReachedWidget({
    super.key,
    required this.place,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.read<MapCubit>().updateLocation(location);
                },
                icon: const Icon(Icons.close, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 50, color: Colors.green),
                const Text(
                  "Destination Reached",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  textAlign: TextAlign.center,
                  place.address!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
