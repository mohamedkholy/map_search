import 'package:flutter/material.dart';
import 'package:map_search/core/theming/my_colors.dart';

class DistanceWidget extends StatelessWidget {
  const DistanceWidget({
    super.key,
    required this.distance,
    required this.title,
    required this.icon,
    this.margin,
  });

  final double distance;
  final String title;
  final IconData icon;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primary.withAlpha(200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 5),
          Column(
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "${distance.toStringAsFixed(2)} km",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
