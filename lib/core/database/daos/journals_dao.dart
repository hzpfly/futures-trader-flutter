// 复盘日志 DAO
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/trade_journals.dart';

part 'journals_dao.g.dart';

@DriftAccessor(tables: [TradeJournals])
class JournalsDao extends DatabaseAccessor<AppDatabase>
    with _$JournalsDaoMixin {
  JournalsDao(super.db);

  /// 获取某交易的复盘日志
  Stream<TradeJournal?> watchJournalByTrade(int tradeId) {
    return (select(tradeJournals)
          ..where((j) => j.tradeId.equals(tradeId)))
        .watchSingleOrNull();
  }

  /// 一次性获取
  Future<TradeJournal?> getJournalByTrade(int tradeId) {
    return (select(tradeJournals)
          ..where((j) => j.tradeId.equals(tradeId)))
        .getSingleOrNull();
  }

  /// 新建或更新复盘日志
  Future<int> upsertJournal(TradeJournalsCompanion journal) {
    return into(tradeJournals).insertOnConflictUpdate(journal);
  }

  /// 删除复盘日志
  Future<int> deleteJournal(int tradeId) {
    return (delete(tradeJournals)..where((j) => j.tradeId.equals(tradeId)))
        .go();
  }

  /// 获取所有有复盘的交易ID列表
  Future<List<int>> getReviewedTradeIds() async {
    final journals = await select(tradeJournals).get();
    return journals.map((j) => j.tradeId).toList();
  }
}
