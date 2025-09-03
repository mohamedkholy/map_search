import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_search/features/map/data/models/location_error.dart';
import 'package:map_search/core/theming/my_colors.dart';
import 'package:map_search/features/map/ui/widgets/expand_button.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorMessage;
  final void Function()? callback;
  final bool? openSettings;
  final VoidCallback onArrowClick;
  final LocationError errorType;
  const ErrorStateWidget({
    super.key,
    required this.errorMessage,
    this.callback,
    this.openSettings,
    required this.onArrowClick,
    required this.errorType,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ExpandButton(arrowUp: true, onArrowClick: onArrowClick),
            ),
            const SizedBox(height: 10),
            Icon(
              errorType == LocationError.locationDenied
                  ? Icons.location_off
                  : errorType == LocationError.noInternet
                  ? Icons.wifi_off
                  : Icons.error,
              size: 40,
              color: Colors.red,
            ),
            const SizedBox(height: 10),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: callback,
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    "Retry",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                if (openSettings == true)
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Geolocator.openAppSettings();
                      },
                      icon: const Icon(Icons.settings),
                      label: const Text(
                        "Open Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
