// 交易主表定义
import 'package:drift/drift.dart';

/// 交易记录主表
class TradeRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 品种代码，如 JD / LH / C / M
  TextColumn get symbol => text().withLength(min: 1, max: 10)();

  /// 合约月份，如 2601 / 2609
  TextColumn get contract => text().withLength(min: 4, max: 6)();

  /// 交易所，如 DCE / CZCE / SHFE / CFFEX
  TextColumn get exchange => text().withLength(min: 1, max: 10)();

  /// 方向：long / short
  TextColumn get direction => text().withLength(min: 4, max: 5)();

  /// 开仓价格
  RealColumn get openPrice => real()();

  /// 开仓时间
  DateTimeColumn get openTime => dateTime()();

  /// 手数
  IntColumn get lots => integer()();

  /// 止损价（可为空）
  RealColumn get stopLoss => real().nullable()();

  /// 止盈价（可为空）
  RealColumn get takeProfit => real().nullable()();

  /// 状态：open / closed / cancelled
  TextColumn get status => text().withDefault(const Constant('open'))();

  /// 三重滤网信号强度评分 1-5
  IntColumn get signalScore => integer().withDefault(const Constant(3))();

  /// 开仓备注
  TextColumn get notes => text().withDefault(const Constant(''))();

  /// 入场理由
  TextColumn get entryReason => text().withDefault(const Constant(''))();

  /// 创建时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 更新时间
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
