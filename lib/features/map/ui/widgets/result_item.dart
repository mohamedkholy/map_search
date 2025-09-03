import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/core/helpers.dart/distance_calculator.dart' as dc;

class ResultItem extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;
  final Function(String)? onArrowClick;
  final Function()? onDeleteClick;
  final bool isFromHistory;
  final LatLng currentLocation;
  final bool isLast;
  const ResultItem({
    super.key,
    required this.place,
    required this.onTap,
    this.onArrowClick,
    this.onDeleteClick,
    required this.isFromHistory,
    required this.currentLocation,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final double distance = dc.DistanceCalculator.distanceToPoint(
      currentLocation,
      LatLng(double.parse(place.lat), double.parse(place.lon)),
    );
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFromHistory ? Icons.history : Icons.location_on,
                          color: Colors.grey.shade800,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (distance < 200)
                        AutoSizeText(
                          minFontSize: 7,
                          maxLines: 1,
                          "${distance.toStringAsFixed(2)} km",
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(place.name),
                      Text(place.address!, maxLines: 1),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                if (onArrowClick != null)
                  GestureDetector(
                    onTap: () => onArrowClick!(place.name),
                    child: const Icon(IconData(0xe806, fontFamily: "ArrowUp")),
                  ),
                if (onDeleteClick != null)
                  GestureDetector(
                    onTap: () => onDeleteClick!(),
                    child: const Icon(Icons.close, color: Colors.grey),
                  ),
              ],
            ),
          ),
          if (!isLast) const Divider(endIndent: 10, indent: 10),
        ],
      ),
    );
  }
}
