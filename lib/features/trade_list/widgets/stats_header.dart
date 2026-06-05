// 统计头部组件
import 'package:flutter/material.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/constants/app_constants.dart';

class StatsHeader extends StatelessWidget {
  final TradeStats stats;
  const StatsHeader({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          _StatCard(
            label: '总盈亏',
            value: stats.pnlDisplay,
            valueColor: stats.totalPnl >= 0 ? kProfitColor : kLossColor,
            suffix: '元',
          ),
          const SizedBox(width: 8),
          _StatCard(
            label: '胜率',
            value: stats.winRateDisplay,
            valueColor: Colors.blue[700]!,
          ),
          const SizedBox(width: 8),
          _StatCard(
            label: '持仓',
            value: stats.openCount.toString(),
            valueColor: Colors.orange[700]!,
            suffix: '笔',
          ),
          const SizedBox(width: 8),
          _StatCard(
            label: '总交易',
            value: stats.totalTrades.toString(),
            valueColor: Colors.grey[700]!,
            suffix: '笔',
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final String suffix;

  const _StatCard({
    required this.label,
    required this.value,
    required this.valueColor,
    this.suffix = '',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 2),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: valueColor,
                    ),
                  ),
                  if (suffix.isNotEmpty)
                    TextSpan(
                      text: suffix,
                      style: TextStyle(
                        fontSize: 11,
                        color: valueColor.withOpacity(0.7),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
