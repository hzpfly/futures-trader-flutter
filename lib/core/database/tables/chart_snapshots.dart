// K线截图表定义
import 'package:drift/drift.dart';
import 'trade_records.dart';

/// K线截图表（每笔交易最多3张，对应三重滤网）
class ChartSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 关联交易ID
  IntColumn get tradeId => integer().references(TradeRecords, #id,
      onDelete: KeyAction.cascade)();

  /// 滤网级别：1 / 2 / 3
  IntColumn get filterLevel => integer()();

  /// 时间周期描述，如 "weekly" / "daily" / "60min" / "15min"
  TextColumn get timeframe => text().withDefault(const Constant(''))();

  /// 本地图片文件路径（相对于App文档目录）
  TextColumn get imagePath => text()();

  /// 截图时间（用户操作时间，不是行情时间）
  DateTimeColumn get capturedAt => dateTime().withDefault(currentDateAndTime)();

  /// 图注（用户对这张图的分析说明）
  TextColumn get annotation => text().withDefault(const Constant(''))();

  /// 图片文件大小（字节），用于统计存储用量
  IntColumn get fileSize => integer().withDefault(const Constant(0))();
}
