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

// ─── 手续费类型 ─────────────────────────────────────
enum FeeType {
  fixed,  // 固定值（元/手）
  ratio,  // 比例（万分之N，按成交金额）
}

// ─── 期货品种定义 ────────────────────────────────────
class FuturesSymbol {
  final String code;
  final String name;
  final String exchange;
  final String unit;            // 合约单位描述
  final String multiplierDesc;  // 合约乘数说明
  final double multiplier;      // 合约乘数（计算盈亏用）
  final FeeType feeType;        // 手续费类型
  final double feeValue;        // 手续费值（固定时=元/手；比例时=万分之N）
  final String feeDesc;         // 手续费显示文字

  const FuturesSymbol({
    required this.code,
    required this.name,
    required this.exchange,
    required this.unit,
    required this.multiplierDesc,
    required this.multiplier,
    required this.feeType,
    required this.feeValue,
    required this.feeDesc,
  });

  String get displayName => '$code $name';

  /// 计算单笔手续费（开仓一手）
  /// price: 成交价格（用于比例手续费计算）
  double calcFee(double price) {
    if (feeType == FeeType.fixed) {
      return feeValue;
    } else {
      // 比例：feeValue 是万分之N，即 feeValue / 10000
      return price * multiplier * (feeValue / 10000);
    }
  }
}

// ─── 预设品种列表（五大交易所主要品种）────────────────
const Map<String, FuturesSymbol> kFuturesSymbols = {

  // ══════════════════════════════════════════════════
  // 上海期货交易所 SHFE
  // ══════════════════════════════════════════════════

  // 有色金属
  'CU': FuturesSymbol(
    code: 'CU', name: '沪铜', exchange: 'SHFE',
    unit: '手=5t', multiplierDesc: '5元/吨',  multiplier: 5,
    feeType: FeeType.ratio, feeValue: 0.05, feeDesc: '0.005‰(约3元/手)',
  ),
  'AL': FuturesSymbol(
    code: 'AL', name: '沪铝', exchange: 'SHFE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'ZN': FuturesSymbol(
    code: 'ZN', name: '沪锌', exchange: 'SHFE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'PB': FuturesSymbol(
    code: 'PB', name: '沪铅', exchange: 'SHFE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'NI': FuturesSymbol(
    code: 'NI', name: '沪镍', exchange: 'SHFE',
    unit: '手=1t', multiplierDesc: '1元/吨', multiplier: 1,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'SN': FuturesSymbol(
    code: 'SN', name: '沪锡', exchange: 'SHFE',
    unit: '手=1t', multiplierDesc: '1元/吨', multiplier: 1,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  // 氧化铝（新品种）
  'AO': FuturesSymbol(
    code: 'AO', name: '氧化铝', exchange: 'SHFE',
    unit: '手=20t', multiplierDesc: '20元/吨', multiplier: 20,
    feeType: FeeType.ratio, feeValue: 0.3, feeDesc: '0.03‰(约3元/手)',
  ),
  // 贵金属
  'AU': FuturesSymbol(
    code: 'AU', name: '黄金', exchange: 'SHFE',
    unit: '手=1000g', multiplierDesc: '1000元/克', multiplier: 1000,
    feeType: FeeType.fixed, feeValue: 10, feeDesc: '10元/手',
  ),
  'AG': FuturesSymbol(
    code: 'AG', name: '白银', exchange: 'SHFE',
    unit: '手=15kg', multiplierDesc: '15元/克', multiplier: 15,
    feeType: FeeType.ratio, feeValue: 0.05, feeDesc: '0.005‰(约3.75元/手)',
  ),
  // 能源化工
  'RB': FuturesSymbol(
    code: 'RB', name: '螺纹钢', exchange: 'SHFE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.ratio, feeValue: 0.1, feeDesc: '0.01‰(约3元/手)',
  ),
  'HC': FuturesSymbol(
    code: 'HC', name: '热轧卷板', exchange: 'SHFE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.ratio, feeValue: 0.1, feeDesc: '0.01‰(约3元/手)',
  ),
  'SS': FuturesSymbol(
    code: 'SS', name: '不锈钢', exchange: 'SHFE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 2, feeDesc: '2元/手',
  ),
  'RU': FuturesSymbol(
    code: 'RU', name: '天胶', exchange: 'SHFE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'NR': FuturesSymbol(
    code: 'NR', name: '20号胶', exchange: 'SHFE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'FU': FuturesSymbol(
    code: 'FU', name: '燃料油', exchange: 'SHFE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.ratio, feeValue: 0.1, feeDesc: '0.01‰(约1.8元/手)',
  ),
  'BU': FuturesSymbol(
    code: 'BU', name: '石油沥青', exchange: 'SHFE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.ratio, feeValue: 0.1, feeDesc: '0.01‰(约1.8元/手)',
  ),
  'SP': FuturesSymbol(
    code: 'SP', name: '纸浆', exchange: 'SHFE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 0.5, feeDesc: '0.5元/手',
  ),
  'LU': FuturesSymbol(
    code: 'LU', name: '低硫燃料油', exchange: 'SHFE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.ratio, feeValue: 0.1, feeDesc: '0.01‰(约2元/手)',
  ),

  // ══════════════════════════════════════════════════
  // 上海国际能源交易中心 INE（原油等）
  // ══════════════════════════════════════════════════
  'SC': FuturesSymbol(
    code: 'SC', name: '原油', exchange: 'INE',
    unit: '手=1000桶', multiplierDesc: '1000元/桶', multiplier: 1000,
    feeType: FeeType.ratio, feeValue: 0.2, feeDesc: '0.02‰(约10元/手)',
  ),
  'BC': FuturesSymbol(
    code: 'BC', name: '国际铜', exchange: 'INE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.ratio, feeValue: 0.05, feeDesc: '0.005‰(约3元/手)',
  ),

  // ══════════════════════════════════════════════════
  // 大连商品交易所 DCE
  // ══════════════════════════════════════════════════

  // 农产品
  'C':  FuturesSymbol(
    code: 'C',  name: '玉米', exchange: 'DCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 1.2, feeDesc: '1.2元/手',
  ),
  'CS': FuturesSymbol(
    code: 'CS', name: '玉米淀粉', exchange: 'DCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 1.5, feeDesc: '1.5元/手',
  ),
  'A':  FuturesSymbol(
    code: 'A',  name: '豆一', exchange: 'DCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 2, feeDesc: '2元/手',
  ),
  'B':  FuturesSymbol(
    code: 'B',  name: '豆二', exchange: 'DCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 2, feeDesc: '2元/手',
  ),
  'M':  FuturesSymbol(
    code: 'M',  name: '豆粕', exchange: 'DCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 1.5, feeDesc: '1.5元/手',
  ),
  'Y':  FuturesSymbol(
    code: 'Y',  name: '豆油', exchange: 'DCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 2.5, feeDesc: '2.5元/手',
  ),
  'P':  FuturesSymbol(
    code: 'P',  name: '棕榈油', exchange: 'DCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 2.5, feeDesc: '2.5元/手',
  ),
  'JD': FuturesSymbol(
    code: 'JD', name: '鸡蛋', exchange: 'DCE',
    unit: '手=5箱(500kg)', multiplierDesc: '10元/点', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 1.5, feeDesc: '1.5元/手',
  ),
  'LH': FuturesSymbol(
    code: 'LH', name: '生猪', exchange: 'DCE',
    unit: '手=16头', multiplierDesc: '16元/吨', multiplier: 16,
    feeType: FeeType.fixed, feeValue: 8, feeDesc: '8元/手',
  ),
  // 化工
  'L':  FuturesSymbol(
    code: 'L',  name: '聚乙烯', exchange: 'DCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 2, feeDesc: '2元/手',
  ),
  'V':  FuturesSymbol(
    code: 'V',  name: '聚氯乙烯', exchange: 'DCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 2, feeDesc: '2元/手',
  ),
  'PP': FuturesSymbol(
    code: 'PP', name: '聚丙烯', exchange: 'DCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 2, feeDesc: '2元/手',
  ),
  'EG': FuturesSymbol(
    code: 'EG', name: '乙二醇', exchange: 'DCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'EB': FuturesSymbol(
    code: 'EB', name: '苯乙烯', exchange: 'DCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'PG': FuturesSymbol(
    code: 'PG', name: '液化石油气', exchange: 'DCE',
    unit: '手=20t', multiplierDesc: '20元/吨', multiplier: 20,
    feeType: FeeType.fixed, feeValue: 6, feeDesc: '6元/手',
  ),
  // 黑色
  'I':  FuturesSymbol(
    code: 'I',  name: '铁矿石', exchange: 'DCE',
    unit: '手=100t', multiplierDesc: '100元/吨', multiplier: 100,
    feeType: FeeType.ratio, feeValue: 1.0, feeDesc: '1‰(约7-8元/手)',
  ),
  'J':  FuturesSymbol(
    code: 'J',  name: '焦炭', exchange: 'DCE',
    unit: '手=100t', multiplierDesc: '100元/吨', multiplier: 100,
    feeType: FeeType.ratio, feeValue: 0.1, feeDesc: '0.01‰(约24-25元/手)',
  ),
  'JM': FuturesSymbol(
    code: 'JM', name: '焦煤', exchange: 'DCE',
    unit: '手=60t', multiplierDesc: '60元/吨', multiplier: 60,
    feeType: FeeType.ratio, feeValue: 0.1, feeDesc: '0.01‰(约13元/手)',
  ),

  // ══════════════════════════════════════════════════
  // 郑州商品交易所 CZCE
  // ══════════════════════════════════════════════════

  // 农产品
  'CF': FuturesSymbol(
    code: 'CF', name: '棉花', exchange: 'CZCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 4.3, feeDesc: '4.3元/手',
  ),
  'CY': FuturesSymbol(
    code: 'CY', name: '棉纱', exchange: 'CZCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 4, feeDesc: '4元/手',
  ),
  'SR': FuturesSymbol(
    code: 'SR', name: '白糖', exchange: 'CZCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'AP': FuturesSymbol(
    code: 'AP', name: '苹果', exchange: 'CZCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 5, feeDesc: '5元/手',
  ),
  'CJ': FuturesSymbol(
    code: 'CJ', name: '红枣', exchange: 'CZCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'PK': FuturesSymbol(
    code: 'PK', name: '花生', exchange: 'CZCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 4, feeDesc: '4元/手',
  ),
  'RM': FuturesSymbol(
    code: 'RM', name: '菜粕', exchange: 'CZCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 1.5, feeDesc: '1.5元/手',
  ),
  'OI': FuturesSymbol(
    code: 'OI', name: '菜油', exchange: 'CZCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.fixed, feeValue: 2.5, feeDesc: '2.5元/手',
  ),
  // 化工
  'MA': FuturesSymbol(
    code: 'MA', name: '甲醇', exchange: 'CZCE',
    unit: '手=10t', multiplierDesc: '10元/吨', multiplier: 10,
    feeType: FeeType.ratio, feeValue: 0.1, feeDesc: '0.01‰(约2.5元/手)',
  ),
  'TA': FuturesSymbol(
    code: 'TA', name: 'PTA', exchange: 'CZCE',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'UR': FuturesSymbol(
    code: 'UR', name: '尿素', exchange: 'CZCE',
    unit: '手=20t', multiplierDesc: '20元/吨', multiplier: 20,
    feeType: FeeType.ratio, feeValue: 1.0, feeDesc: '1‰(约3.3元/手)',
  ),
  // 建材
  'FG': FuturesSymbol(
    code: 'FG', name: '玻璃', exchange: 'CZCE',
    unit: '手=20t', multiplierDesc: '20元/吨', multiplier: 20,
    feeType: FeeType.fixed, feeValue: 6, feeDesc: '6元/手',
  ),
  'SA': FuturesSymbol(
    code: 'SA', name: '纯碱', exchange: 'CZCE',
    unit: '手=20t', multiplierDesc: '20元/吨', multiplier: 20,
    feeType: FeeType.ratio, feeValue: 0.2, feeDesc: '0.02‰(约5.6元/手)',
  ),
  'SH': FuturesSymbol(
    code: 'SH', name: '烧碱', exchange: 'CZCE',
    unit: '手=30t', multiplierDesc: '30元/吨', multiplier: 30,
    feeType: FeeType.ratio, feeValue: 0.2, feeDesc: '0.02‰(约2元/手)',
  ),

  // ══════════════════════════════════════════════════
  // 中国金融期货交易所 CFFEX
  // ══════════════════════════════════════════════════

  // 股指期货
  'IF': FuturesSymbol(
    code: 'IF', name: '沪深300', exchange: 'CFFEX',
    unit: '手=300元/点', multiplierDesc: '300元/点', multiplier: 300,
    feeType: FeeType.ratio, feeValue: 0.23, feeDesc: '0.023‰ 开仓 / 2.3‰ 平今(约27元/手)',
  ),
  'IC': FuturesSymbol(
    code: 'IC', name: '中证500', exchange: 'CFFEX',
    unit: '手=200元/点', multiplierDesc: '200元/点', multiplier: 200,
    feeType: FeeType.ratio, feeValue: 0.23, feeDesc: '0.023‰ 开仓 / 2.3‰ 平今(约14元/手)',
  ),
  'IH': FuturesSymbol(
    code: 'IH', name: '上证50', exchange: 'CFFEX',
    unit: '手=300元/点', multiplierDesc: '300元/点', multiplier: 300,
    feeType: FeeType.ratio, feeValue: 0.23, feeDesc: '0.023‰ 开仓 / 2.3‰ 平今(约18元/手)',
  ),
  'IM': FuturesSymbol(
    code: 'IM', name: '中证1000', exchange: 'CFFEX',
    unit: '手=200元/点', multiplierDesc: '200元/点', multiplier: 200,
    feeType: FeeType.ratio, feeValue: 0.23, feeDesc: '0.023‰ 开仓 / 2.3‰ 平今(约12元/手)',
  ),
  // 国债期货
  'TF': FuturesSymbol(
    code: 'TF', name: '5年期国债', exchange: 'CFFEX',
    unit: '手=100万元面值', multiplierDesc: '10000元/点', multiplier: 10000,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'T':  FuturesSymbol(
    code: 'T',  name: '10年期国债', exchange: 'CFFEX',
    unit: '手=100万元面值', multiplierDesc: '10000元/点', multiplier: 10000,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'TS': FuturesSymbol(
    code: 'TS', name: '2年期国债', exchange: 'CFFEX',
    unit: '手=200万元面值', multiplierDesc: '20000元/点', multiplier: 20000,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),
  'TL': FuturesSymbol(
    code: 'TL', name: '30年期国债', exchange: 'CFFEX',
    unit: '手=100万元面值', multiplierDesc: '10000元/点', multiplier: 10000,
    feeType: FeeType.fixed, feeValue: 3, feeDesc: '3元/手',
  ),

  // ══════════════════════════════════════════════════
  // 广州期货交易所 GFEX（新品种）
  // ══════════════════════════════════════════════════
  'SI': FuturesSymbol(
    code: 'SI', name: '工业硅', exchange: 'GFEX',
    unit: '手=5t', multiplierDesc: '5元/吨', multiplier: 5,
    feeType: FeeType.ratio, feeValue: 0.2, feeDesc: '0.02‰(约1.5元/手)',
  ),
  'LC': FuturesSymbol(
    code: 'LC', name: '碳酸锂', exchange: 'GFEX',
    unit: '手=1t', multiplierDesc: '1元/吨', multiplier: 1,
    feeType: FeeType.ratio, feeValue: 0.2, feeDesc: '0.02‰(约2元/手)',
  ),
  'PS': FuturesSymbol(
    code: 'PS', name: '多晶硅', exchange: 'GFEX',
    unit: '手=3t', multiplierDesc: '3元/吨', multiplier: 3,
    feeType: FeeType.ratio, feeValue: 0.2, feeDesc: '0.02‰(约1.5元/手)',
  ),
};

// 常用品种列表（首页默认展示）
const List<String> kDefaultSymbols = [
  'AO', 'M', 'C', 'I', 'MA', 'FG', 'SA', 'CF', 'AP', 'RB', 'AU', 'IF',
];

// 交易所中文名
const Map<String, String> kExchangeNames = {
  'SHFE': '上期所',
  'INE':  '上期能源',
  'DCE':  '大商所',
  'CZCE': '郑商所',
  'CFFEX':'中金所',
  'GFEX': '广期所',
};

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
