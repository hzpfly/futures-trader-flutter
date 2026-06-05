// 复盘日志表定义
import 'package:drift/drift.dart';
import 'trade_records.dart';

/// 复盘日志（每笔交易一条，盘后分析记录）
class TradeJournals extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 关联交易ID（唯一，一对一）
  IntColumn get tradeId => integer().unique().references(TradeRecords, #id,
      onDelete: KeyAction.cascade)();

  /// 复盘正文（Markdown格式）
  TextColumn get reviewText => text().withDefault(const Constant(''))();

  /// 情绪标签：calm / impulsive / hesitant / fearful / greedy
  TextColumn get emotionTag => text().withDefault(const Constant('calm'))();

  /// 执行纪律评分 1-5，5分=完全按计划执行
  IntColumn get disciplineScore => integer().withDefault(const Constant(3))();

  /// 策略标签，JSON数组字符串，如 '["顺势交易","突破开仓"]'
  TextColumn get strategyTags =>
      text().withDefault(const Constant('[]'))();

  /// 犯了什么错误（可为空）
  TextColumn get mistakes => text().withDefault(const Constant(''))();

  /// 下次改进方向
  TextColumn get improvements => text().withDefault(const Constant(''))();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
