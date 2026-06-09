// Riverpod Provider 全局依赖注入
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../database/daos/trades_dao.dart';
import '../database/daos/snapshots_dao.dart';
import '../database/daos/close_records_dao.dart';
import '../database/daos/journals_dao.dart';

// ─── 数据库单例 ────────────────────────────────────────
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// ─── DAO Providers ────────────────────────────────────
final tradesDaoProvider = Provider<TradesDao>((ref) {
  return ref.watch(appDatabaseProvider).tradesDao;
});

final snapshotsDaoProvider = Provider<SnapshotsDao>((ref) {
  return ref.watch(appDatabaseProvider).snapshotsDao;
});

final closeRecordsDaoProvider = Provider<CloseRecordsDao>((ref) {
  return ref.watch(appDatabaseProvider).closeRecordsDao;
});

final journalsDaoProvider = Provider<JournalsDao>((ref) {
  return ref.watch(appDatabaseProvider).journalsDao;
});

// ─── 月份选择 Provider ────────────────────────────────
/// 当前选中的月份（默认本月）
final selectedMonthProvider =
    StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
});

// ─── 交易列表 Providers ───────────────────────────────
/// 按状态筛选的交易列表
final tradeListByStatusProvider =
    StreamProvider.family<List<TradeRecord>, String>((ref, status) {
  final dao = ref.watch(tradesDaoProvider);
  if (status == 'all') return dao.watchAllTrades();
  return dao.watchTradesByStatus(status);
});

/// 所有交易列表
final allTradesProvider = StreamProvider<List<TradeRecord>>((ref) {
  return ref.watch(tradesDaoProvider).watchAllTrades();
});

/// 持仓中交易数量
final openTradeCountProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(tradeListByStatusProvider('open')).whenData((l) => l.length);
});

// ─── 单条交易 ─────────────────────────────────────────
final tradeByIdProvider =
    StreamProvider.family<TradeRecord?, int>((ref, id) {
  return ref.watch(tradesDaoProvider).watchTradeById(id);
});

// ─── 截图 Providers ───────────────────────────────────
final snapshotsByTradeProvider =
    StreamProvider.family<List<ChartSnapshot>, int>((ref, tradeId) {
  return ref.watch(snapshotsDaoProvider).watchSnapshotsByTrade(tradeId);
});

// ─── 平仓记录 Providers ───────────────────────────────
final closeRecordsByTradeProvider =
    StreamProvider.family<List<CloseRecord>, int>((ref, tradeId) {
  return ref.watch(closeRecordsDaoProvider).watchCloseRecordsByTrade(tradeId);
});

// ─── 复盘日志 Providers ───────────────────────────────
final journalByTradeProvider =
    StreamProvider.family<TradeJournal?, int>((ref, tradeId) {
  return ref.watch(journalsDaoProvider).watchJournalByTrade(tradeId);
});

// ─── 统计 Provider ────────────────────────────────────
/// 按月统计（传入 DateTime(year, month) 的月份）
final monthStatsProvider =
    FutureProvider.family<TradeStats, DateTime>((ref, month) async {
  final dao = ref.watch(tradesDaoProvider);
  final closeDao = ref.watch(closeRecordsDaoProvider);

  final startDate = DateTime(month.year, month.month);
  final endDate = DateTime(month.year, month.month + 1);

  // 该月开仓的所有交易
  final allTrades = await dao.getAllTrades();
  final monthTrades = allTrades
      .where((t) =>
          t.openTime.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
          t.openTime.isBefore(endDate))
      .toList();

  if (monthTrades.isEmpty) return TradeStats.empty();

  final closedTrades =
      monthTrades.where((t) => t.status == 'closed').toList();
  double totalPnl = 0;
  int winCount = 0;
  int lossCount = 0;

  for (final t in closedTrades) {
    final pnl = await closeDao.getTotalPnlByTrade(t.id);
    totalPnl += pnl;
    if (pnl > 0) winCount++;
    if (pnl < 0) lossCount++;
  }

  final openCount = monthTrades.where((t) => t.status == 'open').length;
  final winRate =
      closedTrades.isEmpty ? 0.0 : winCount / closedTrades.length;

  return TradeStats(
    totalTrades: monthTrades.length,
    openCount: openCount,
    closedCount: closedTrades.length,
    totalPnl: totalPnl,
    winCount: winCount,
    lossCount: lossCount,
    winRate: winRate,
  );
});

final tradeStatsProvider = FutureProvider<TradeStats>((ref) async {
  final dao = ref.watch(tradesDaoProvider);
  final closeDao = ref.watch(closeRecordsDaoProvider);
  final trades = await dao.getAllTrades();

  if (trades.isEmpty) {
    return TradeStats.empty();
  }

  final closedTrades = trades.where((t) => t.status == 'closed').toList();
  double totalPnl = 0;
  int winCount = 0;
  int lossCount = 0;

  for (final t in closedTrades) {
    final pnl = await closeDao.getTotalPnlByTrade(t.id);
    totalPnl += pnl;
    if (pnl > 0) winCount++;
    if (pnl < 0) lossCount++;
  }

  final openCount = trades.where((t) => t.status == 'open').length;
  final winRate =
      closedTrades.isEmpty ? 0.0 : winCount / closedTrades.length;

  return TradeStats(
    totalTrades: trades.length,
    openCount: openCount,
    closedCount: closedTrades.length,
    totalPnl: totalPnl,
    winCount: winCount,
    lossCount: lossCount,
    winRate: winRate,
  );
});

/// 统计数据模型
class TradeStats {
  final int totalTrades;
  final int openCount;
  final int closedCount;
  final double totalPnl;
  final int winCount;
  final int lossCount;
  final double winRate;

  const TradeStats({
    required this.totalTrades,
    required this.openCount,
    required this.closedCount,
    required this.totalPnl,
    required this.winCount,
    required this.lossCount,
    required this.winRate,
  });

  factory TradeStats.empty() => const TradeStats(
        totalTrades: 0,
        openCount: 0,
        closedCount: 0,
        totalPnl: 0,
        winCount: 0,
        lossCount: 0,
        winRate: 0,
      );

  String get winRateDisplay => '${(winRate * 100).toStringAsFixed(1)}%';
  String get pnlDisplay {
    if (totalPnl >= 0) return '+${totalPnl.toStringAsFixed(0)}';
    return totalPnl.toStringAsFixed(0);
  }
}
