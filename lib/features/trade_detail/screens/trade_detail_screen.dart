// 交易详情页 - K线三联展示 + 平仓操作 + 复盘
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:drift/drift.dart' show Value;
import '../../../core/database/app_database.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/constants/app_constants.dart';

class TradeDetailScreen extends ConsumerWidget {
  final int tradeId;
  const TradeDetailScreen({super.key, required this.tradeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradeAsync = ref.watch(tradeByIdProvider(tradeId));
    final snapshotsAsync = ref.watch(snapshotsByTradeProvider(tradeId));
    final closeRecordsAsync =
        ref.watch(closeRecordsByTradeProvider(tradeId));

    return tradeAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('加载失败：$e'))),
      data: (trade) {
        if (trade == null) {
          return const Scaffold(body: Center(child: Text('交易记录不存在')));
        }
        return _TradeDetailContent(
          trade: trade,
          snapshotsAsync: snapshotsAsync,
          closeRecordsAsync: closeRecordsAsync,
        );
      },
    );
  }
}

class _TradeDetailContent extends ConsumerWidget {
  final TradeRecord trade;
  final AsyncValue<List<ChartSnapshot>> snapshotsAsync;
  final AsyncValue<List<CloseRecord>> closeRecordsAsync;

  const _TradeDetailContent({
    required this.trade,
    required this.snapshotsAsync,
    required this.closeRecordsAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbol = kFuturesSymbols[trade.symbol];
    final isLong = trade.direction == 'long';
    final isOpen = trade.status == 'open';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          '${trade.symbol}${trade.contract} ${isLong ? "多" : "空"}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (isOpen)
            TextButton.icon(
              onPressed: () =>
                  _showCloseDialog(context, ref),
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('平仓'),
              style:
                  TextButton.styleFrom(foregroundColor: kShortColor),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // 基本信息卡片
          _BasicInfoCard(trade: trade, symbol: symbol),
          const SizedBox(height: 12),
          // K线三联截图
          _ChartGallerySection(snapshotsAsync: snapshotsAsync),
          const SizedBox(height: 12),
          // 平仓记录
          _CloseRecordsSection(
              closeRecordsAsync: closeRecordsAsync, trade: trade),
          const SizedBox(height: 12),
          // 复盘日志
          _JournalSection(tradeId: trade.id),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _showCloseDialog(BuildContext context, WidgetRef ref) async {
    final openLots = trade.lots;
    final closedLotsAsync =
        ref.read(closeRecordsDaoProvider).getClosedLotsByTrade(trade.id);
    final closedLots = await closedLotsAsync;
    final remainingLots = openLots - closedLots;

    if (remainingLots <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('该交易已全部平仓')),
      );
      return;
    }

    if (context.mounted) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (ctx) => _CloseTradeSheet(
          trade: trade,
          remainingLots: remainingLots,
        ),
      );
    }
  }
}

// ─── 基本信息卡片 ──────────────────────────────────────
class _BasicInfoCard extends StatelessWidget {
  final TradeRecord trade;
  final FuturesSymbol? symbol;

  const _BasicInfoCard({required this.trade, required this.symbol});

  @override
  Widget build(BuildContext context) {
    final isLong = trade.direction == 'long';
    final dirColor = isLong ? kLongColor : kShortColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  trade.symbol,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${symbol?.name ?? ''} ${trade.contract}',
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: dirColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: dirColor.withOpacity(0.4)),
                ),
                child: Text(
                  isLong ? '做多' : '做空',
                  style: TextStyle(
                    color: dirColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          _InfoRow(items: [
            _InfoCell(label: '开仓价', value: trade.openPrice.toStringAsFixed(2)),
            _InfoCell(label: '手数', value: '${trade.lots}手'),
            _InfoCell(
              label: '状态',
              value: TradeStatus.values
                  .firstWhere((s) => s.name == trade.status)
                  .label,
              valueColor:
                  trade.status == 'open' ? Colors.orange : Colors.grey,
            ),
          ]),
          const SizedBox(height: 10),
          _InfoRow(items: [
            _InfoCell(
              label: '止损',
              value: trade.stopLoss?.toStringAsFixed(2) ?? '--',
              valueColor: trade.stopLoss != null ? kShortColor : Colors.grey,
            ),
            _InfoCell(
              label: '止盈',
              value: trade.takeProfit?.toStringAsFixed(2) ?? '--',
              valueColor:
                  trade.takeProfit != null ? kLongColor : Colors.grey,
            ),
            _InfoCell(
              label: '信号强度',
              value: '★' * trade.signalScore,
              valueColor: Colors.amber[700]!,
            ),
          ]),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.access_time, size: 13, color: Colors.grey[400]),
              const SizedBox(width: 4),
              Text(
                '开仓：${DateFormat('yyyy-MM-dd HH:mm').format(trade.openTime)}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          if (trade.entryReason.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text('入场理由',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(
              trade.entryReason,
              style: const TextStyle(fontSize: 13, height: 1.5),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── K线截图展示区 ────────────────────────────────────
class _ChartGallerySection extends StatelessWidget {
  final AsyncValue<List<ChartSnapshot>> snapshotsAsync;
  const _ChartGallerySection({required this.snapshotsAsync});

  @override
  Widget build(BuildContext context) {
    return snapshotsAsync.when(
      loading: () => const SizedBox(height: 40),
      error: (_, __) => const SizedBox.shrink(),
      data: (snapshots) {
        if (snapshots.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text('三重滤网K线截图',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 16),
                Icon(Icons.image_not_supported_outlined,
                    size: 48, color: Colors.grey[300]),
                const SizedBox(height: 8),
                const Text('暂无截图',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('三重滤网K线截图',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 12),
              ...snapshots.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _SnapshotCard(snapshot: s, allSnapshots: snapshots),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class _SnapshotCard extends StatelessWidget {
  final ChartSnapshot snapshot;
  final List<ChartSnapshot> allSnapshots;

  const _SnapshotCard(
      {required this.snapshot, required this.allSnapshots});

  static const _levelColors = [
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFE65100),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _levelColors[(snapshot.filterLevel - 1).clamp(0, 2)];
    final tf = kFilterTimeframes[(snapshot.filterLevel - 1).clamp(0, 2)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(
                child: Text(
                  '${snapshot.filterLevel}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '${tf.name} · ${snapshot.timeframe}',
              style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _openFullscreen(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(snapshot.imagePath),
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey[100],
                child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey)),
              ),
            ),
          ),
        ),
        if (snapshot.annotation.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            snapshot.annotation,
            style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
        ],
      ],
    );
  }

  void _openFullscreen(BuildContext context) {
    final initialIndex =
        allSnapshots.indexWhere((s) => s.id == snapshot.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullscreenGallery(
          snapshots: allSnapshots,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

class _FullscreenGallery extends StatelessWidget {
  final List<ChartSnapshot> snapshots;
  final int initialIndex;

  const _FullscreenGallery(
      {required this.snapshots, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('K线截图'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: snapshots.length,
        scrollPhysics: const BouncingScrollPhysics(),
        pageController: PageController(initialPage: initialIndex),
        builder: (ctx, i) {
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(snapshots[i].imagePath)),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          );
        },
        loadingBuilder: (_, __) =>
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// ─── 平仓记录区 ───────────────────────────────────────
class _CloseRecordsSection extends StatelessWidget {
  final AsyncValue<List<CloseRecord>> closeRecordsAsync;
  final TradeRecord trade;

  const _CloseRecordsSection(
      {required this.closeRecordsAsync, required this.trade});

  @override
  Widget build(BuildContext context) {
    return closeRecordsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (records) {
        if (records.isEmpty) return const SizedBox.shrink();
        final totalPnl = records.fold(
            0.0, (sum, r) => sum + r.pnl - r.commission);
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('平仓记录',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  const Spacer(),
                  Text(
                    '总盈亏：${totalPnl >= 0 ? '+' : ''}${totalPnl.toStringAsFixed(0)}元',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: totalPnl >= 0 ? kProfitColor : kLossColor,
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              ...records.map((r) => _CloseRecordItem(record: r)),
            ],
          ),
        );
      },
    );
  }
}

class _CloseRecordItem extends StatelessWidget {
  final CloseRecord record;
  const _CloseRecordItem({required this.record});

  @override
  Widget build(BuildContext context) {
    final pnl = record.pnl - record.commission;
    final pnlColor = pnl >= 0 ? kProfitColor : kLossColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '平仓 ${record.closeLots}手 @ ${record.closePrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Text(
                  DateFormat('MM-dd HH:mm').format(record.closeTime) +
                      '  ${CloseReason.values.firstWhere((c) => c.name == record.closeReason, orElse: () => CloseReason.manual).label}',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            '${pnl >= 0 ? '+' : ''}${pnl.toStringAsFixed(0)}元',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: pnlColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 复盘日志区 ───────────────────────────────────────
class _JournalSection extends ConsumerWidget {
  final int tradeId;
  const _JournalSection({required this.tradeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journalAsync = ref.watch(journalByTradeProvider(tradeId));

    return journalAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (journal) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('复盘日志',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () =>
                      _showJournalEditor(context, ref, journal),
                  icon: Icon(
                    journal == null ? Icons.add : Icons.edit,
                    size: 16,
                  ),
                  label: Text(journal == null ? '写复盘' : '编辑'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue[700],
                  ),
                ),
              ],
            ),
            if (journal != null) ...[
              const Divider(height: 16),
              // 情绪+纪律评分
              Row(
                children: [
                  _JournalChip(
                    label: EmotionTag.values
                        .firstWhere((e) => e.name == journal.emotionTag,
                            orElse: () => EmotionTag.calm)
                        .label,
                    emoji: EmotionTag.values
                        .firstWhere((e) => e.name == journal.emotionTag,
                            orElse: () => EmotionTag.calm)
                        .emoji,
                  ),
                  const SizedBox(width: 8),
                  _JournalChip(
                    label: '纪律 ${journal.disciplineScore}/5',
                    emoji: '',
                  ),
                ],
              ),
              if (journal.reviewText.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  journal.reviewText,
                  style: const TextStyle(fontSize: 13, height: 1.6),
                ),
              ],
            ] else
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '还没有写复盘，点击「写复盘」记录分析...',
                  style: TextStyle(
                      fontSize: 13, color: Colors.grey[400]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showJournalEditor(
      BuildContext context, WidgetRef ref, TradeJournal? journal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) =>
          _JournalEditorSheet(tradeId: tradeId, existing: journal),
    );
  }
}

class _JournalChip extends StatelessWidget {
  final String label;
  final String emoji;
  const _JournalChip({required this.label, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text('$emoji $label'.trim(),
          style: const TextStyle(fontSize: 12)),
    );
  }
}

// ─── 平仓操作弹窗 ─────────────────────────────────────
class _CloseTradeSheet extends ConsumerStatefulWidget {
  final TradeRecord trade;
  final int remainingLots;
  const _CloseTradeSheet(
      {required this.trade, required this.remainingLots});

  @override
  ConsumerState<_CloseTradeSheet> createState() => _CloseTradeSheetState();
}

class _CloseTradeSheetState extends ConsumerState<_CloseTradeSheet> {
  final _closePriceCtrl = TextEditingController();
  final _lotsCtrl = TextEditingController();
  final _commissionCtrl = TextEditingController(text: '0');
  String _closeReason = 'manual';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _lotsCtrl.text = widget.remainingLots.toString();
  }

  @override
  void dispose() {
    _closePriceCtrl.dispose();
    _lotsCtrl.dispose();
    _commissionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('平仓操作',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _closePriceCtrl,
                  decoration: const InputDecoration(
                    labelText: '平仓价格 *',
                    hintText: '0.00',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  autofocus: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _lotsCtrl,
                  decoration: InputDecoration(
                    labelText: '平仓手数',
                    suffixText: '/ ${widget.remainingLots}手',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _commissionCtrl,
                  decoration: const InputDecoration(
                    labelText: '手续费(元)',
                    hintText: '0',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _closeReason,
                  decoration: const InputDecoration(labelText: '平仓原因'),
                  items: CloseReason.values
                      .map((r) => DropdownMenuItem(
                          value: r.name, child: Text(r.label)))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _closeReason = v!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _doClose,
              style: ElevatedButton.styleFrom(
                backgroundColor: kShortColor,
                foregroundColor: Colors.white,
              ),
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Text('确认平仓'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _doClose() async {
    final closePrice = double.tryParse(_closePriceCtrl.text);
    final closeLots = int.tryParse(_lotsCtrl.text);
    final commission =
        double.tryParse(_commissionCtrl.text) ?? 0;
    if (closePrice == null || closeLots == null || closeLots <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('请填写平仓价格和手数')));
      return;
    }

    setState(() => _isSaving = true);

    try {
      // 计算盈亏（方向价差 × 合约乘数 × 手数）
      final isLong = widget.trade.direction == 'long';
      final priceDiff = isLong
          ? closePrice - widget.trade.openPrice
          : widget.trade.openPrice - closePrice;
      final symbol = kFuturesSymbols[widget.trade.symbol];
      final multiplier = symbol?.multiplier ?? 1.0;
      final pnl = priceDiff * multiplier * closeLots;

      await ref.read(closeRecordsDaoProvider).insertCloseRecord(
            CloseRecordsCompanion.insert(
              tradeId: widget.trade.id,
              closePrice: closePrice,
              closeTime: DateTime.now(),
              closeLots: closeLots,
              pnl: pnl,
              commission: Value(commission),
              closeReason: Value(_closeReason),
            ),
          );

      // 检查是否全部平仓
      final totalClosed = await ref
          .read(closeRecordsDaoProvider)
          .getClosedLotsByTrade(widget.trade.id);
      if (totalClosed >= widget.trade.lots) {
        await ref
            .read(tradesDaoProvider)
            .updateTradeStatus(widget.trade.id, 'closed');
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('平仓记录已保存'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('保存失败：$e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

// ─── 复盘日志编辑弹窗 ──────────────────────────────────
class _JournalEditorSheet extends ConsumerStatefulWidget {
  final int tradeId;
  final TradeJournal? existing;
  const _JournalEditorSheet(
      {required this.tradeId, required this.existing});

  @override
  ConsumerState<_JournalEditorSheet> createState() =>
      _JournalEditorSheetState();
}

class _JournalEditorSheetState
    extends ConsumerState<_JournalEditorSheet> {
  late TextEditingController _reviewCtrl;
  String _emotionTag = 'calm';
  int _disciplineScore = 3;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _reviewCtrl = TextEditingController(
        text: widget.existing?.reviewText ?? '');
    _emotionTag = widget.existing?.emotionTag ?? 'calm';
    _disciplineScore = widget.existing?.disciplineScore ?? 3;
  }

  @override
  void dispose() {
    _reviewCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('写复盘',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          // 情绪选择
          const Text('交易时情绪',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: EmotionTag.values
                .map((e) => ChoiceChip(
                      label: Text('${e.emoji} ${e.label}'),
                      selected: _emotionTag == e.name,
                      onSelected: (_) =>
                          setState(() => _emotionTag = e.name),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          // 纪律评分
          Row(
            children: [
              const Text('执行纪律：',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              ...List.generate(
                5,
                (i) => GestureDetector(
                  onTap: () =>
                      setState(() => _disciplineScore = i + 1),
                  child: Icon(
                    i < _disciplineScore
                        ? Icons.star
                        : Icons.star_outline,
                    size: 26,
                    color: i < _disciplineScore
                        ? Colors.amber
                        : Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _reviewCtrl,
            decoration: const InputDecoration(
              hintText: '记录复盘心得、改进方向...',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('保存复盘'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await ref.read(journalsDaoProvider).upsertJournal(
            TradeJournalsCompanion.insert(
              tradeId: widget.tradeId,
              reviewText: Value(_reviewCtrl.text),
              emotionTag: Value(_emotionTag),
              disciplineScore: Value(_disciplineScore),
              updatedAt: Value(DateTime.now()),
            ),
          );
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

// ─── 通用工具组件 ──────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final List<_InfoCell> items;
  const _InfoRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items
          .map((item) => Expanded(child: item))
          .toList(),
    );
  }
}

class _InfoCell extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoCell(
      {required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            )),
      ],
    );
  }
}
