import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/core/theming/my_colors.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/map/logic/map_cubit.dart';
import 'package:map_search/features/map/ui/widgets/result_item.dart';

class HistoryScreen extends StatefulWidget {
  final LatLng currentLocation;
  const HistoryScreen({super.key, required this.currentLocation});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final MapCubit _mapCubit = context.read();
  late final List<Place> history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        centerTitle: true,
        title: const Text('History'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: _mapCubit.getHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text("No data"));
            }
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("No data"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: MyColors.primary),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ResultItem(
                  place: snapshot.data![index],
                  onTap: () {
                    Navigator.pop(context, snapshot.data![index]);
                  },
                  isFromHistory: true,
                  onDeleteClick: () async {
                    await _mapCubit.deletePlaceFromHistory(
                      snapshot.data![index],
                    );
                    setState(() {});
                  },
                  currentLocation: widget.currentLocation,
                  isLast: index == snapshot.data!.length - 1,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
