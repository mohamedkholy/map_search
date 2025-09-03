import 'package:drift/drift.dart';

class History extends Table {
  IntColumn get placeId => integer().named("place_id")();
  TextColumn get licence => text()();
  TextColumn get osmType => text().named("osm_type")();
  IntColumn get osmId => integer().named("osm_id")();
  TextColumn get lat => text()();
  TextColumn get lon => text()();
  TextColumn get className => text().named("class")();
  TextColumn get type => text()();
  IntColumn get placeRank => integer().named("place_rank")();
  RealColumn get importance => real()();
  TextColumn get addresstype => text()();
  TextColumn get name => text()();
  TextColumn get displayName => text().named("display_name")();
  TextColumn get boundingbox => text()();
  TextColumn get address => text()();

  @override
  Set<Column> get primaryKey => {placeId};
}
