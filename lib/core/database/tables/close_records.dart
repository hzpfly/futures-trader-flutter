// 平仓记录表定义
import 'package:drift/drift.dart';
import 'trade_records.dart';

/// 平仓记录（支持分批平仓，一笔交易可以有多条平仓记录）
class CloseRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 关联交易ID
  IntColumn get tradeId => integer().references(TradeRecords, #id,
      onDelete: KeyAction.cascade)();

  /// 平仓价格
  RealColumn get closePrice => real()();

  /// 平仓时间
  DateTimeColumn get closeTime => dateTime()();

  /// 本次平仓手数
  IntColumn get closeLots => integer()();

  /// 盈亏金额（元），正数为盈利，负数为亏损
  RealColumn get pnl => real()();

  /// 手续费（元）
  RealColumn get commission => real().withDefault(const Constant(0.0))();

  /// 滑点损耗（点数）
  RealColumn get slipPoints => real().withDefault(const Constant(0.0))();

  /// 平仓原因：stopLoss / takeProfit / manual / reversal / expiry
  TextColumn get closeReason => text().withDefault(const Constant('manual'))();

  /// 平仓备注
  TextColumn get notes => text().withDefault(const Constant(''))();

  /// 记录创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
