// 路由配置
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/trade_list/screens/trade_list_screen.dart';
import '../features/trade_entry/screens/trade_entry_screen.dart';
import '../features/trade_detail/screens/trade_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TradeListScreen(),
    ),
    GoRoute(
      path: '/trade/new',
      builder: (context, state) => const TradeEntryScreen(),
    ),
    GoRoute(
      path: '/trade/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return TradeDetailScreen(tradeId: id);
      },
    ),
    GoRoute(
      path: '/trade/:id/edit',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return TradeEntryScreen(editTradeId: id);
      },
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const _AnalyticsPlaceholder(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const _SettingsPlaceholder(),
    ),
  ],
);

// 占位页面，后续实现
class _AnalyticsPlaceholder extends StatelessWidget {
  const _AnalyticsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('盘后分析')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bar_chart, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('盘后分析模块开发中...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _SettingsPlaceholder extends StatelessWidget {
  const _SettingsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.settings, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('设置页面开发中...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
