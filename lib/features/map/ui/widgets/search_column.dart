import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/features/map/logic/map_cubit.dart';
import 'package:map_search/features/map/logic/map_state.dart';
import 'package:map_search/features/map/ui/widgets/result_item.dart';
import 'package:map_search/features/map/ui/widgets/search_text_field.dart';

class SearchColumn extends StatefulWidget {
  final LatLng currentLocation;
  const SearchColumn({super.key, required this.currentLocation});

  @override
  State<SearchColumn> createState() => _SearchColumnState();
}

List<Place> places = [];
List<Place> history = [];

class _SearchColumnState extends State<SearchColumn> {
  late LatLng currentLocation = widget.currentLocation;
  final Debouncer _debouncer = Debouncer();
  final ValueNotifier<bool> resultsVisible = ValueNotifier(false);
  final TextEditingController _searchController = TextEditingController();
  late final MapCubit _mapCubit = context.read();
  final FocusNode focusNode = FocusNode();

  @override
  void didUpdateWidget(covariant SearchColumn oldWidget) {
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
              SearchTextField(
                onClosePressed: _closeSearch,
                ontextChanged: (value) {
                  _debouncer.debounce(
                    duration: const Duration(milliseconds: 800),
                    onDebounce: () {
                      context.read<MapCubit>().search(value);
                    },
                  );
                },
                onTap: () {
                  resultsVisible.value = true;
                  _mapCubit.getHistory();
                },
                isResultsVisible: resultsVisible,
                searchController: _searchController,
                focusNode: focusNode,
              ),
              Flexible(
                child: BlocConsumer<MapCubit, MapState>(
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
                    final resultList = historyPlaces + placesToDisplay;
                    return ValueListenableBuilder(
                      valueListenable: resultsVisible,
                      builder: (context, value, child) {
                        return value ? child! : const SizedBox.shrink();
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
                                ...List.generate(resultList.length, (index) {
                                  final inHistory =
                                      index < historyPlaces.length;
                                  return ResultItem(
                                    currentLocation: currentLocation,
                                    place: resultList[index],
                                    onArrowClick: (name) {
                                      _mapCubit.search(name);
                                      _searchController.value =
                                          TextEditingValue(text: name);
                                    },
                                    onTap: () {
                                      _mapCubit.fetchRouteFromOSRM(
                                        currentLocation,
                                        resultList[index],
                                      );
                                      if (!inHistory) {
                                        _mapCubit.addPlaceToHistory(
                                          resultList[index],
                                        );
                                      }
                                      _closeSearch();
                                    },
                                    isFromHistory: inHistory,
                                    isLast: index == resultList.length - 1,
                                  );
                                }),
                                if (resultList.isNotEmpty)
                                  const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
