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
    final stats = ref.watch(tradeStatsProvider);

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
          // 统计头部
          stats.when(
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

  const _TradeListTab({required this.status, required this.symbolFilter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradesAsync = ref.watch(tradeListByStatusProvider(status));

    return tradesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('加载失败：$e')),
      data: (trades) {
        // 品种筛选
        final filtered = symbolFilter == 'all'
            ? trades
            : trades.where((t) => t.symbol == symbolFilter).toList();

        if (filtered.isEmpty) {
          return _EmptyState(status: status);
        }

        return RefreshIndicator(
          onRefresh: () async {},
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) => TradeListItem(trade: filtered[i]),
          ),
        );
      },
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
      'all': '还没有交易记录\n点击右下角「新建交易」开始记录',
      'open': '暂无持仓中的交易',
      'closed': '暂无已平仓的交易',
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
