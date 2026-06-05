// K线截图 DAO
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/chart_snapshots.dart';

part 'snapshots_dao.g.dart';

@DriftAccessor(tables: [ChartSnapshots])
class SnapshotsDao extends DatabaseAccessor<AppDatabase>
    with _$SnapshotsDaoMixin {
  SnapshotsDao(super.db);

  /// 获取某交易的所有截图（按滤网级别排序）
  Stream<List<ChartSnapshot>> watchSnapshotsByTrade(int tradeId) {
    return (select(chartSnapshots)
          ..where((s) => s.tradeId.equals(tradeId))
          ..orderBy([(s) => OrderingTerm.asc(s.filterLevel)]))
        .watch();
  }

  /// 一次性获取
  Future<List<ChartSnapshot>> getSnapshotsByTrade(int tradeId) {
    return (select(chartSnapshots)
          ..where((s) => s.tradeId.equals(tradeId))
          ..orderBy([(s) => OrderingTerm.asc(s.filterLevel)]))
        .get();
  }

  /// 获取某级别截图
  Future<ChartSnapshot?> getSnapshotByLevel(int tradeId, int level) {
    return (select(chartSnapshots)
          ..where(
              (s) => s.tradeId.equals(tradeId) & s.filterLevel.equals(level)))
        .getSingleOrNull();
  }

  /// 新建截图记录
  Future<int> insertSnapshot(ChartSnapshotsCompanion snapshot) {
    return into(chartSnapshots).insert(snapshot);
  }

  /// 插入或替换（同一交易+同一级别只保留最新的）
  Future<int> upsertSnapshot(ChartSnapshotsCompanion snapshot) {
    return into(chartSnapshots).insertOnConflictUpdate(snapshot);
  }

  /// 更新截图（替换图片路径）
  Future<bool> updateSnapshot(ChartSnapshot snapshot) {
    return update(chartSnapshots).replace(snapshot);
  }

  /// 删除某张截图
  Future<int> deleteSnapshot(int id) {
    return (delete(chartSnapshots)..where((s) => s.id.equals(id))).go();
  }

  /// 获取所有截图（用于K线回放库）
  Stream<List<ChartSnapshot>> watchAllSnapshots() {
    return (select(chartSnapshots)
          ..orderBy([(s) => OrderingTerm.desc(s.capturedAt)]))
        .watch();
  }
}
