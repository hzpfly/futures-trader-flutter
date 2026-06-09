// 交易记录 DAO
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/trade_records.dart';

part 'trades_dao.g.dart';

@DriftAccessor(tables: [TradeRecords])
class TradesDao extends DatabaseAccessor<AppDatabase> with _$TradesDaoMixin {
  TradesDao(super.db);

  // ─── 查询 ──────────────────────────────────────────

  /// 获取所有交易记录（按时间倒序）
  Stream<List<TradeRecord>> watchAllTrades() {
    return (select(tradeRecords)
          ..orderBy([(t) => OrderingTerm.desc(t.openTime)]))
        .watch();
  }

  /// 按状态筛选
  Stream<List<TradeRecord>> watchTradesByStatus(String status) {
    return (select(tradeRecords)
          ..where((t) => t.status.equals(status))
          ..orderBy([(t) => OrderingTerm.desc(t.openTime)]))
        .watch();
  }

  /// 按品种筛选
  Stream<List<TradeRecord>> watchTradesBySymbol(String symbol) {
    return (select(tradeRecords)
          ..where((t) => t.symbol.equals(symbol))
          ..orderBy([(t) => OrderingTerm.desc(t.openTime)]))
        .watch();
  }

  /// 获取单条交易
  Stream<TradeRecord?> watchTradeById(int id) {
    return (select(tradeRecords)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// 一次性获取单条交易（编辑模式用）
  Future<TradeRecord?> getTradeById(int id) {
    return (select(tradeRecords)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// 一次性获取所有交易（用于统计）
  Future<List<TradeRecord>> getAllTrades() {
    return (select(tradeRecords)
          ..orderBy([(t) => OrderingTerm.desc(t.openTime)]))
        .get();
  }

  /// 获取持仓中的交易
  Future<List<TradeRecord>> getOpenTrades() {
    return (select(tradeRecords)
          ..where((t) => t.status.equals('open'))
          ..orderBy([(t) => OrderingTerm.desc(t.openTime)]))
        .get();
  }

  /// 按月份查询（用于日历视图）
  Future<List<TradeRecord>> getTradesByMonth(int year, int month) {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 1);
    return (select(tradeRecords)
          ..where((t) =>
              t.openTime.isBiggerOrEqualValue(startDate) &
              t.openTime.isSmallerThanValue(endDate))
          ..orderBy([(t) => OrderingTerm.asc(t.openTime)]))
        .get();
  }

  // ─── 写入 ──────────────────────────────────────────

  /// 新建交易
  Future<int> insertTrade(TradeRecordsCompanion trade) {
    return into(tradeRecords).insert(trade);
  }

  /// 更新交易
  Future<bool> updateTrade(TradeRecord trade) {
    return update(tradeRecords).replace(trade);
  }

  /// 更新状态
  Future<int> updateTradeStatus(int id, String status) {
    return (update(tradeRecords)..where((t) => t.id.equals(id))).write(
      TradeRecordsCompanion(
        status: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// 删除交易（同时级联删除截图和复盘）
  Future<int> deleteTrade(int id) {
    return (delete(tradeRecords)..where((t) => t.id.equals(id))).go();
  }
}
