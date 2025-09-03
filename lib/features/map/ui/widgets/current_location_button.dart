import 'package:flutter/material.dart';
import 'package:map_search/core/theming/my_colors.dart';

class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: MyColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Icon(
              Icons.my_location_rounded,
              color: Colors.white,
              size: 20,
            ),
    );
  }
}
