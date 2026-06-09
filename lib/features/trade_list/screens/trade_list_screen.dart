// 交易列表主页面
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/constants/app_constants.dart';
import '../widgets/trade_list_item.dart';
import '../widgets/stats_header.dart';

class TradeListScreen extends ConsumerStatefulWidget {
  const TradeListScreen({super.key});

  @override
  ConsumerState<TradeListScreen> createState() => _TradeListScreenState();
}

class _TradeListScreenState extends ConsumerState<TradeListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedSymbol = 'all';

  final _tabs = const [
    Tab(text: '全部'),
    Tab(text: '持仓中'),
    Tab(text: '已平仓'),
  ];

  final _statusKeys = ['all', 'open', 'closed'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    // 按天统计优先，否则按月统计
    final statsAsync = selectedDay != null
        ? ref.watch(dayStatsProvider(selectedDay))
        : ref.watch(monthStatsProvider(selectedMonth));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          '三重滤网交易记录',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_outlined),
            tooltip: '盘后分析',
            onPressed: () => context.push('/analytics'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: '设置',
            onPressed: () => context.push('/settings'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          indicatorWeight: 2,
        ),
      ),
        body: Column(
          children: [
            // 月份切换栏
            _MonthSelector(selectedMonth: selectedMonth),
            // 日期选择行（选中某天时显示）
            _DaySelector(),
            // 统计头部（按当前月份/日期）
          statsAsync.when(
            data: (s) => StatsHeader(stats: s),
            loading: () => const SizedBox(height: 80),
            error: (_, __) => const SizedBox(height: 8),
          ),
          // 品种筛选栏
          _SymbolFilter(
            selected: _selectedSymbol,
            onChanged: (v) => setState(() => _selectedSymbol = v),
          ),
          // 交易列表
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _statusKeys
                  .map((status) => _TradeListTab(
                        status: status,
                        symbolFilter: _selectedSymbol,
                        selectedMonth: selectedMonth,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/trade/new'),
        icon: const Icon(Icons.add),
        label: const Text('新建交易'),
        backgroundColor: kLongColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// ─── 月份切换栏 ───────────────────────────────────────
class _MonthSelector extends ConsumerWidget {
  final DateTime selectedMonth;

  const _MonthSelector({required this.selectedMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final isCurrentMonth =
        selectedMonth.year == now.year && selectedMonth.month == now.month;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 上个月
          IconButton(
            icon: const Icon(Icons.chevron_left),
            iconSize: 22,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            onPressed: () {
              ref.read(selectedMonthProvider.notifier).state = DateTime(
                selectedMonth.year,
                selectedMonth.month - 1,
              );
            },
          ),
          // 月份显示 + 点击弹出选择器
          GestureDetector(
            onTap: () => _showMonthPicker(context, ref, selectedMonth),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('yyyy年M月').format(selectedMonth),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down,
                      size: 18, color: Color(0xFF1565C0)),
                ],
              ),
            ),
          ),
          // 下个月（不超过本月）
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: isCurrentMonth ? Colors.grey[300] : null,
            ),
            iconSize: 22,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            onPressed: isCurrentMonth
                ? null
                : () {
                    ref.read(selectedMonthProvider.notifier).state = DateTime(
                      selectedMonth.year,
                      selectedMonth.month + 1,
                    );
                  },
          ),
          // 回到本月按钮
          if (!isCurrentMonth) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                ref.read(selectedMonthProvider.notifier).state =
                    DateTime(now.year, now.month);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: kLongColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: kLongColor.withOpacity(0.4)),
                ),
                child: Text(
                  '本月',
                  style: TextStyle(
                      fontSize: 11,
                      color: kLongColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showMonthPicker(
      BuildContext context, WidgetRef ref, DateTime current) {
    final now = DateTime.now();
    // 生成最近36个月的选项
    final months = List.generate(36, (i) {
      return DateTime(now.year, now.month - i);
    });

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                '选择月份',
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: months.length,
                itemBuilder: (_, i) {
                  final m = months[i];
                  final isSelected =
                      m.year == current.year && m.month == current.month;
                  return ListTile(
                    title: Text(
                      DateFormat('yyyy年M月').format(m),
                      style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check,
                            color:
                                Theme.of(context).colorScheme.primary)
                        : null,
                    onTap: () {
                      ref.read(selectedMonthProvider.notifier).state = m;
                      Navigator.pop(ctx);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 品种筛选条 ──────────────────────────────────────
class _SymbolFilter extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _SymbolFilter({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final symbols = ['all', ...kDefaultSymbols];
    return Container(
      height: 40,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        itemCount: symbols.length,
        itemBuilder: (ctx, i) {
          final s = symbols[i];
          final isSelected = s == selected;
          final label = s == 'all'
              ? '全部品种'
              : '${kFuturesSymbols[s]?.name ?? s}($s)';
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(s),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── 单个Tab的交易列表 ────────────────────────────────
class _TradeListTab extends ConsumerWidget {
  final String status;
  final String symbolFilter;
  final DateTime selectedMonth;

  const _TradeListTab({
    required this.status,
    required this.symbolFilter,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedDayProvider);
    final tradesAsync = ref.watch(tradeListByStatusProvider(status));

    return tradesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败：$e')),
      data: (trades) {
        // 月份过滤（持仓中 Tab 不过滤，始终显示全部持仓）
        List<TradeRecord> monthFiltered;
        if (status == 'open') {
          monthFiltered = trades;
        } else {
          final startDate = DateTime(selectedMonth.year, selectedMonth.month);
          final endDate =
              DateTime(selectedMonth.year, selectedMonth.month + 1);
          monthFiltered = trades
              .where((t) =>
                  t.openTime.isAfter(
                      startDate.subtract(const Duration(seconds: 1))) &&
                  t.openTime.isBefore(endDate))
              .toList();
        }

        // 按天过滤（如果选择了日期）
        List<TradeRecord> dayFiltered;
        if (status == 'open') {
          dayFiltered = monthFiltered;
        } else if (selectedDay != null) {
          final dayStart =
              DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
          final dayEnd = dayStart.add(const Duration(days: 1));
          dayFiltered = monthFiltered.where((t) =>
              t.openTime.isAfter(
                      dayStart.subtract(const Duration(seconds: 1))) &&
              t.openTime.isBefore(dayEnd)).toList();
        } else {
          dayFiltered = monthFiltered;
        }

        // 品种筛选
        final filtered = symbolFilter == 'all'
            ? dayFiltered
            : dayFiltered
                .where((t) => t.symbol == symbolFilter)
                .toList();

        if (filtered.isEmpty) {
          return _EmptyState(status: status);
        }

        // 按日期分组
        final groups = _groupByDate(filtered);

        return RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 80),
            itemCount: groups.length,
            itemBuilder: (ctx, i) {
              final entry = groups[i];
              if (entry is _DateHeader) {
                return _DateHeaderWidget(label: entry.label);
              } else if (entry is TradeRecord) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TradeListItem(trade: entry),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }

  /// 将交易列表按日期分组，插入日期标题
  List<dynamic> _groupByDate(List<TradeRecord> trades) {
    final result = <dynamic>[];
    String? lastDate;

    for (final trade in trades) {
      final dateKey = DateFormat('yyyy-MM-dd').format(trade.openTime);
      final dateLabel = _formatDateLabel(trade.openTime);

      if (dateKey != lastDate) {
        result.add(_DateHeader(label: dateLabel));
        lastDate = dateKey;
      }
      result.add(trade);
    }
    return result;
  }

  String _formatDateLabel(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(dt.year, dt.month, dt.day);

    final weekdays = ['一', '二', '三', '四', '五', '六', '日'];
    final weekday = weekdays[dt.weekday - 1];

    if (date == today) {
      return '今天  周$weekday  ${DateFormat('M月d日').format(dt)}';
    } else if (date == yesterday) {
      return '昨天  周$weekday  ${DateFormat('M月d日').format(dt)}';
    } else {
      return '${DateFormat('M月d日').format(dt)}  周$weekday';
    }
  }
}

class _DateHeader {
  final String label;
  const _DateHeader({required this.label});
}

// ─── 日期分隔标题 ─────────────────────────────────────
class _DateHeaderWidget extends StatelessWidget {
  final String label;
  const _DateHeaderWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 6),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 空状态 ───────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final String status;
  const _EmptyState({required this.status});

  @override
  Widget build(BuildContext context) {
    final messages = {
      'all': '本月暂无交易记录\n点击右下角「新建交易」开始记录',
      'open': '暂无持仓中的交易',
      'closed': '本月暂无已平仓的交易',
    };
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            messages[status] ?? '暂无数据',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ─── 日期选择器 ─────────────────────────────────────
class _DaySelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedDayProvider);

    if (selectedDay == null) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => _pickDay(context, ref),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.calendar_today, size: 12, color: Color(0xFF1565C0)),
                SizedBox(width: 4),
                Text(
                  '选择日期',
                  style: TextStyle(fontSize: 11, color: Color(0xFF1565C0)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final weekdays = ['一', '二', '三', '四', '五', '六', '日'];
    final weekday = weekdays[selectedDay.weekday - 1];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${DateFormat('yyyy年M月d日').format(selectedDay)}  周$weekday',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          GestureDetector(
            onTap: () => ref.read(selectedDayProvider.notifier).state = null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('清除', style: TextStyle(fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }

  void _pickDay(BuildContext context, WidgetRef ref) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: ref.read(selectedDayProvider) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      ref.read(selectedDayProvider.notifier).state = picked;
      ref.read(selectedMonthProvider.notifier).state =
          DateTime(picked.year, picked.month);
    }
  }
}
