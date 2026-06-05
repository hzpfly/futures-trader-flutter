// 平仓记录 DAO
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/close_records.dart';

part 'close_records_dao.g.dart';

@DriftAccessor(tables: [CloseRecords])
class CloseRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$CloseRecordsDaoMixin {
  CloseRecordsDao(super.db);

  /// 获取某交易的所有平仓记录（时间顺序）
  Stream<List<CloseRecord>> watchCloseRecordsByTrade(int tradeId) {
    return (select(closeRecords)
          ..where((c) => c.tradeId.equals(tradeId))
          ..orderBy([(c) => OrderingTerm.asc(c.closeTime)]))
        .watch();
  }

  /// 一次性获取
  Future<List<CloseRecord>> getCloseRecordsByTrade(int tradeId) {
    return (select(closeRecords)
          ..where((c) => c.tradeId.equals(tradeId))
          ..orderBy([(c) => OrderingTerm.asc(c.closeTime)]))
        .get();
  }

  /// 新建平仓记录
  Future<int> insertCloseRecord(CloseRecordsCompanion record) {
    return into(closeRecords).insert(record);
  }

  /// 更新平仓记录
  Future<bool> updateCloseRecord(CloseRecord record) {
    return update(closeRecords).replace(record);
  }

  /// 删除平仓记录
  Future<int> deleteCloseRecord(int id) {
    return (delete(closeRecords)..where((c) => c.id.equals(id))).go();
  }

  /// 计算某交易总盈亏
  Future<double> getTotalPnlByTrade(int tradeId) async {
    final records = await getCloseRecordsByTrade(tradeId);
    double total = 0.0;
    for (final r in records) {
      total = total + r.pnl - r.commission;
    }
    return total;
  }

  /// 计算某交易已平手数
  Future<int> getClosedLotsByTrade(int tradeId) async {
    final records = await getCloseRecordsByTrade(tradeId);
    int total = 0;
    for (final r in records) {
      total = total + r.closeLots;
    }
    return total;
  }

  /// 获取日期范围内的平仓记录（用于统计分析）
  Future<List<CloseRecord>> getCloseRecordsInRange(
      DateTime start, DateTime end) {
    return (select(closeRecords)
          ..where((c) =>
              c.closeTime.isBiggerOrEqualValue(start) &
              c.closeTime.isSmallerThanValue(end))
          ..orderBy([(c) => OrderingTerm.asc(c.closeTime)]))
        .get();
  }
}
