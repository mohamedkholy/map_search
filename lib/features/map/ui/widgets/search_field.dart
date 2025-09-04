import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/map/logic/map_cubit.dart';
import 'package:map_search/features/map/logic/map_state.dart';
import 'package:map_search/features/map/ui/widgets/result_item.dart';

class SearchField extends StatefulWidget {
  final LatLng currentLocation;
  const SearchField({super.key, required this.currentLocation});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

List<Place> places = [];
List<Place> history = [];

class _SearchFieldState extends State<SearchField> {
  late LatLng currentLocation = widget.currentLocation;
  final Debouncer throttler = Debouncer();
  final ValueNotifier<bool> resultsVisible = ValueNotifier(false);
  final TextEditingController _searchController = TextEditingController();
  late final MapCubit _mapCubit = context.read();
  final FocusNode focusNode = FocusNode();

  @override
  void didUpdateWidget(covariant SearchField oldWidget) {
    currentLocation = widget.currentLocation;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    resultsVisible.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onTap: () {
                          resultsVisible.value = true;
                          _mapCubit.getHistory();
                        },
                        controller: _searchController,
                        focusNode: focusNode,
                        onChanged: (value) {
                          throttler.debounce(
                            duration: const Duration(milliseconds: 800),
                            onDebounce: () {
                              context.read<MapCubit>().search(value);
                            },
                          );
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: resultsVisible,
                      builder: (context, value, child) {
                        return value ? child! : Container();
                      },
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _closeSearch();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BlocConsumer<MapCubit, MapState>(
                listener: (context, state) {
                  if (state is SearchReslutsLoaded) {
                    if (state.places.isNotEmpty) {
                      resultsVisible.value = true;
                    }
                  }
                },
                builder: (context, state) {
                  if (state is SearchReslutsLoaded) {
                    places = state.places;
                  }
                  if (state is HistoryLoaded) {
                    history = state.history;
                  }
                  final historyPlaces = history
                      .where(
                        (element) => element.name.toLowerCase().contains(
                          _searchController.text.toLowerCase(),
                        ),
                      )
                      .toList();
                  final placesToDisplay = places
                      .where((place) => !historyPlaces.contains(place))
                      .toList();
                  return ValueListenableBuilder(
                    valueListenable: resultsVisible,
                    builder: (context, value, child) {
                      return value ? child! : Container();
                    },
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 400),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 5),
                              if (historyPlaces.isNotEmpty)
                                for (int i = 0; i < historyPlaces.length; i++)
                                  ResultItem(
                                    currentLocation: currentLocation,
                                    onArrowClick: (name) {
                                      _mapCubit.search(name);
                                      _searchController.value =
                                          TextEditingValue(text: name);
                                    },
                                    place: historyPlaces[i],
                                    onTap: () {
                                      _mapCubit.fetchRouteFromOSRM(
                                        currentLocation,
                                        historyPlaces[i],
                                      );
                                      _closeSearch();
                                    },
                                    isFromHistory: true,
                                    isLast:
                                        i == historyPlaces.length - 1 &&
                                        placesToDisplay.isEmpty,
                                  ),
                              ...List.generate(placesToDisplay.length, (index) {
                                return ResultItem(
                                  currentLocation: currentLocation,
                                  place: placesToDisplay[index],
                                  onArrowClick: (name) {
                                    _mapCubit.search(name);
                                    _searchController.value = TextEditingValue(
                                      text: name,
                                    );
                                  },
                                  onTap: () {
                                    print(
                                      "placeId ${placesToDisplay[index].placeId}",
                                    );
                                    _mapCubit.fetchRouteFromOSRM(
                                      currentLocation,
                                      placesToDisplay[index],
                                    );
                                    _mapCubit.addPlaceToHistory(
                                      placesToDisplay[index],
                                    );
                                    _closeSearch();
                                  },
                                  isFromHistory: false,
                                  isLast: index == placesToDisplay.length - 1,
                                );
                              }),
                              if (historyPlaces.isNotEmpty ||
                                  placesToDisplay.isNotEmpty)
                                const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _closeSearch() {
    focusNode.unfocus();
    resultsVisible.value = false;
    places.clear();
    history.clear();
    _searchController.clear();
  }
}
