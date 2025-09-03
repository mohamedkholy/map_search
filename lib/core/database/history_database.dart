import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:map_search/core/database/history_tables.dart';

part 'history_database.g.dart';

@DriftDatabase(tables: [History])
class HistoryDatabase extends _$HistoryDatabase {
  HistoryDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: "my_db");
  }
}
