// 交易列表单项组件
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/constants/app_constants.dart';

class TradeListItem extends ConsumerWidget {
  final TradeRecord trade;
  const TradeListItem({super.key, required this.trade});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbol = kFuturesSymbols[trade.symbol];
    final isLong = trade.direction == 'long';
    final directionColor = isLong ? kLongColor : kShortColor;
    final isOpen = trade.status == 'open';

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            onPressed: (_) => _confirmDelete(context, ref),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            label: '删除',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => context.push('/trade/${trade.id}'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 第一行：品种标签 + 方向 + 状态
                Row(
                  children: [
                    // 品种 Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1565C0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        trade.symbol,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // 品种名称
                    Text(
                      symbol?.name ?? '',
                      style: const TextStyle(
                          fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trade.contract,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey),
                    ),
                    const Spacer(),
                    // 方向标签
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: directionColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: directionColor.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        isLong ? '多' : '空',
                        style: TextStyle(
                          color: directionColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // 状态
                    if (isOpen)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '持仓中',
                          style: TextStyle(
                              fontSize: 11, color: Colors.orange[700]),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                // 第二行：价格信息
                Row(
                  children: [
                    _InfoItem(
                        label: '开仓价',
                        value: trade.openPrice.toStringAsFixed(2)),
                    const SizedBox(width: 20),
                    _InfoItem(
                        label: '手数',
                        value: '${trade.lots}手'),
                    if (trade.stopLoss != null) ...[
                      const SizedBox(width: 20),
                      _InfoItem(
                        label: '止损',
                        value: trade.stopLoss!.toStringAsFixed(2),
                        valueColor: kShortColor,
                      ),
                    ],
                    const Spacer(),
                    // 信号强度星星
                    _SignalStars(score: trade.signalScore),
                  ],
                ),
                const SizedBox(height: 8),
                // 第三行：时间 + 截图数量
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 12, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('MM-dd HH:mm').format(trade.openTime),
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey[500]),
                    ),
                    const Spacer(),
                    // 盈亏显示（已平仓的交易）
                    if (!isOpen) _PnlDisplay(tradeId: trade.id),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content:
            Text('确定要删除 ${trade.symbol}${trade.contract} 的交易记录吗？\n此操作不可恢复。'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(tradesDaoProvider).deleteTrade(trade.id);
    }
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoItem(
      {required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Colors.grey)),
        Text(value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            )),
      ],
    );
  }
}

class _SignalStars extends StatelessWidget {
  final int score;
  const _SignalStars({required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (i) => Icon(
          i < score ? Icons.star : Icons.star_outline,
          size: 12,
          color: i < score ? Colors.amber : Colors.grey[300],
        ),
      ),
    );
  }
}

// 异步加载盈亏
class _PnlDisplay extends ConsumerWidget {
  final int tradeId;
  const _PnlDisplay({required this.tradeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final closeRecords = ref.watch(closeRecordsByTradeProvider(tradeId));
    return closeRecords.when(
      data: (records) {
        final pnl = records.fold(
            0.0, (sum, r) => sum + r.pnl - r.commission);
        final color = pnl >= 0 ? kProfitColor : kLossColor;
        return Text(
          pnl >= 0
              ? '+${pnl.toStringAsFixed(0)}元'
              : '${pnl.toStringAsFixed(0)}元',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
