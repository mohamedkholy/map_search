import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/map/ui/widgets/expand_button.dart';
import 'package:map_search/features/map/ui/widgets/route_details_column.dart';

class RouteDetailsWidget extends StatefulWidget {
  const RouteDetailsWidget({
    super.key,
    required this.place,
    required this.currentLocation,
    required this.route,
  });

  final Place place;
  final LatLng currentLocation;
  final List<LatLng> route;

  @override
  State<RouteDetailsWidget> createState() => _RouteDetailsWidgetState();
}

class _RouteDetailsWidgetState extends State<RouteDetailsWidget> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(20, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Route details",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              ExpandButton(
                arrowUp: !isExpanded,
                onArrowClick: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ],
          ),

          if (isExpanded)
            RouteDetailsColumn(
              place: widget.place,
              currentLocation: widget.currentLocation,
              route: widget.route,
            ),
        ],
      ),
    );
  }
}
