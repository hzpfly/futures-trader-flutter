// 期货品种常量和枚举定义
import 'package:flutter/material.dart';

// ─── 交易方向 ───────────────────────────────────────
enum TradeDirection {
  long('多', '做多', Colors.red),
  short('空', '做空', Color(0xFF00AA00));

  final String label;
  final String fullLabel;
  final Color color;
  const TradeDirection(this.label, this.fullLabel, this.color);
}

// ─── 交易状态 ───────────────────────────────────────
enum TradeStatus {
  open('持仓中'),
  closed('已平仓'),
  cancelled('已取消');

  final String label;
  const TradeStatus(this.label);
}

// ─── 情绪标签 ───────────────────────────────────────
enum EmotionTag {
  calm('冷静', '😌', Color(0xFF4CAF50)),
  impulsive('冲动', '😤', Color(0xFFF44336)),
  hesitant('犹豫', '😐', Color(0xFFFF9800)),
  fearful('恐惧', '😨', Color(0xFF9C27B0)),
  greedy('贪婪', '🤑', Color(0xFFFF5722));

  final String label;
  final String emoji;
  final Color color;
  const EmotionTag(this.label, this.emoji, this.color);
}

// ─── 平仓原因 ───────────────────────────────────────
enum CloseReason {
  stopLoss('止损'),
  takeProfit('止盈'),
  manual('主动平仓'),
  reversal('反向建仓'),
  expiry('交割平仓');

  final String label;
  const CloseReason(this.label);
}

// ─── 期货品种定义 ────────────────────────────────────
class FuturesSymbol {
  final String code;
  final String name;
  final String exchange;
  final String unit;
  final String multiplierDesc; // 合约乘数说明
  final double multiplier;   // 合约乘数（计算盈亏用）

  const FuturesSymbol({
    required this.code,
    required this.name,
    required this.exchange,
    required this.unit,
    required this.multiplierDesc,
    required this.multiplier,
  });

  String get displayName => '$code $name';
}

// ─── 预设品种列表 ─────────────────────────────────────
const Map<String, FuturesSymbol> kFuturesSymbols = {
  // 农产品 - 大连
  'JD': FuturesSymbol(code: 'JD', name: '鸡蛋', exchange: 'DCE', unit: '手=500kg', multiplierDesc: '10元/点', multiplier: 10),
  'LH': FuturesSymbol(code: 'LH', name: '生猪', exchange: 'DCE', unit: '手=16头', multiplierDesc: '16元/吨', multiplier: 16),
  'C':  FuturesSymbol(code: 'C',  name: '玉米', exchange: 'DCE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  'M':  FuturesSymbol(code: 'M',  name: '豆粕', exchange: 'DCE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  'A':  FuturesSymbol(code: 'A',  name: '豆一', exchange: 'DCE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  'Y':  FuturesSymbol(code: 'Y',  name: '豆油', exchange: 'DCE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  'P':  FuturesSymbol(code: 'P',  name: '棕榈油', exchange: 'DCE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  // 农产品 - 郑商所
  'CF': FuturesSymbol(code: 'CF', name: '棉花', exchange: 'CZCE', unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5),
  'CJ': FuturesSymbol(code: 'CJ', name: '红枣', exchange: 'CZCE', unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5),
  'SR': FuturesSymbol(code: 'SR', name: '白糖', exchange: 'CZCE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  'AP': FuturesSymbol(code: 'AP', name: '苹果', exchange: 'CZCE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  // 化工
  'MA': FuturesSymbol(code: 'MA', name: '甲醇', exchange: 'CZCE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  'TA': FuturesSymbol(code: 'TA', name: '对二甲苯', exchange: 'CZCE', unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5),
  // 建材
  'FG': FuturesSymbol(code: 'FG', name: '玻璃', exchange: 'CZCE', unit: '手=20t', multiplierDesc: '20元/吨', multiplier: 20),
  'SA': FuturesSymbol(code: 'SA', name: '纯碱', exchange: 'CZCE', unit: '手=20t', multiplierDesc: '20元/吨', multiplier: 20),
  'RB': FuturesSymbol(code: 'RB', name: '螺纹钢', exchange: 'SHFE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  'HC': FuturesSymbol(code: 'HC', name: '热轧卷板', exchange: 'SHFE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  // 能源
  'SC': FuturesSymbol(code: 'SC', name: '原油', exchange: 'INE', unit: '手=1000桶', multiplierDesc: '1000元/桶', multiplier: 1000),
  'RU': FuturesSymbol(code: 'RU', name: '天胶', exchange: 'SHFE', unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10),
  // 贵金属
  'AU': FuturesSymbol(code: 'AU', name: '黄金', exchange: 'SHFE', unit: '手=1000g', multiplierDesc: '1000元/克', multiplier: 1000),
  'AG': FuturesSymbol(code: 'AG', name: '白银', exchange: 'SHFE', unit: '手=15kg', multiplierDesc: '15元/克', multiplier: 15),
  // 股指
  'IF': FuturesSymbol(code: 'IF', name: '沪深300', exchange: 'CFFEX', unit: '手=300元/点', multiplierDesc: '300元/点', multiplier: 300),
  'IC': FuturesSymbol(code: 'IC', name: '中证500', exchange: 'CFFEX', unit: '手=200元/点', multiplierDesc: '200元/点', multiplier: 200),
  'IH': FuturesSymbol(code: 'IH', name: '上证50', exchange: 'CFFEX', unit: '手=300元/点', multiplierDesc: '300元/点', multiplier: 300),
};

// 常用品种列表（首页默认展示）
const List<String> kDefaultSymbols = ['JD', 'LH', 'M', 'C', 'MA', 'FG', 'CF', 'CJ'];

// ─── 三重滤网时间周期 ─────────────────────────────────
class FilterTimeframe {
  final int level;
  final String name;
  final String description;
  final String example;

  const FilterTimeframe({
    required this.level,
    required this.name,
    required this.description,
    required this.example,
  });
}

const List<FilterTimeframe> kFilterTimeframes = [
  FilterTimeframe(
    level: 1,
    name: '第一重滤网',
    description: '大周期趋势方向',
    example: '周线 / 月线',
  ),
  FilterTimeframe(
    level: 2,
    name: '第二重滤网',
    description: '中周期入场时机',
    example: '日线',
  ),
  FilterTimeframe(
    level: 3,
    name: '第三重滤网',
    description: '小周期精确入场',
    example: '60分钟 / 15分钟',
  ),
];

// ─── 策略标签 ────────────────────────────────────────
const List<String> kStrategyTags = [
  '顺势交易', '逆势交易', '突破开仓', '回调入场',
  '支撑位买入', '压力位做空', '趋势跟踪', '震荡操作',
  'MACD金叉', 'MACD死叉', 'KDJ超卖', 'KDJ超买',
  'RSI背离', '均线系统', '量价配合', '季节规律',
];

// ─── 颜色常量 ────────────────────────────────────────
const kLongColor = Color(0xFFD32F2F);    // 多单 - 红
const kShortColor = Color(0xFF2E7D32);   // 空单 - 绿
const kProfitColor = Color(0xFFD32F2F);  // 盈利 - 红（期货惯例）
const kLossColor = Color(0xFF2E7D32);    // 亏损 - 绿
const kNeutralColor = Color(0xFF757575); // 中性
