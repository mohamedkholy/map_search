import 'package:drift/drift.dart';
import 'package:map_search/features/map/data/models/place.dart';
import 'package:map_search/core/database/history_database.dart';

class MapRepo {
  final _db = HistoryDatabase();

  Future<void> addPlaceToHistory(Place place) async {
    await _db
        .into(_db.history)
        .insert(
          place.toCompanion(),
          onConflict: DoUpdate((conflict) => place.toCompanion()),
        );
  }

  Future<List<Place>> getHistory() async {
    final result = await _db.select(_db.history).get();
    return result.map((row) => PlaceDataMapper.fromData(row)).toList();
  }

  Future<void> deletePlaceFromHistory(Place place) async {
    await _db.delete(_db.history).delete(place.toCompanion());
  }
}
