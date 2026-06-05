// App数据库入口
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/trade_records.dart';
import 'tables/chart_snapshots.dart';
import 'tables/close_records.dart';
import 'tables/trade_journals.dart';
import 'daos/trades_dao.dart';
import 'daos/snapshots_dao.dart';
import 'daos/close_records_dao.dart';
import 'daos/journals_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    TradeRecords,
    ChartSnapshots,
    CloseRecords,
    TradeJournals,
  ],
  daos: [
    TradesDao,
    SnapshotsDao,
    CloseRecordsDao,
    JournalsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // 未来版本升级迁移逻辑
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'futures_trader', 'trades.db'));
    await file.parent.create(recursive: true);
    return NativeDatabase.createInBackground(file);
  });
}
