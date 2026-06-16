// 新建/编辑交易页面 - 步骤式录入（三重滤网核心）
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/database/app_database.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/image_manager.dart';
import '../../../shared/constants/app_constants.dart';

class TradeEntryScreen extends ConsumerStatefulWidget {
  final int? editTradeId; // 编辑模式时传入
  const TradeEntryScreen({super.key, this.editTradeId});

  @override
  ConsumerState<TradeEntryScreen> createState() => _TradeEntryScreenState();
}

class _TradeEntryScreenState extends ConsumerState<TradeEntryScreen> {
  final _pageController = PageController();
  int _currentStep = 0;

  // Step 1: 基本信息
  final _openPriceCtrl = TextEditingController();
  final _lotsCtrl = TextEditingController(text: '1');
  final _stopLossCtrl = TextEditingController();
  final _takeProfitCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _entryReasonCtrl = TextEditingController();
  String _selectedSymbol = 'CF';
  String _contract = '';
  TradeDirection _direction = TradeDirection.long;
  int _signalScore = 3;

  // Step 2: 三重滤网截图
  final Map<int, String?> _imagePaths = {1: null, 2: null, 3: null};
  final Map<int, TextEditingController> _annotationCtrls = {
    1: TextEditingController(),
    2: TextEditingController(),
    3: TextEditingController(),
  };

  bool _isSaving = false;
  bool _isLoading = false;
  TradeRecord? _editTrade; // 编辑模式下的原始数据

  bool get _isEditMode => widget.editTradeId != null;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _contract =
        '${now.year.toString().substring(2)}${now.month.toString().padLeft(2, '0')}';

    if (_isEditMode) {
      _isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadTradeData());
    }
  }

  Future<void> _loadTradeData() async {
    try {
      final tradesDao = ref.read(tradesDaoProvider);
      final snapshotsDao = ref.read(snapshotsDaoProvider);
      final trade = await tradesDao.getTradeById(widget.editTradeId!);

      if (trade == null || !mounted) return;

      final snapshots = await snapshotsDao.getSnapshotsByTrade(trade.id);

      setState(() {
        _editTrade = trade;
        _selectedSymbol = trade.symbol;
        _contract = trade.contract;
        _direction = trade.direction == 'long'
            ? TradeDirection.long
            : TradeDirection.short;
        _openPriceCtrl.text = trade.openPrice.toStringAsFixed(2);
        _lotsCtrl.text = trade.lots.toString();
        if (trade.stopLoss != null) {
          _stopLossCtrl.text = trade.stopLoss!.toStringAsFixed(2);
        }
        if (trade.takeProfit != null) {
          _takeProfitCtrl.text = trade.takeProfit!.toStringAsFixed(2);
        }
        _signalScore = trade.signalScore;
        _notesCtrl.text = trade.notes;
        _entryReasonCtrl.text = trade.entryReason;

        // 加载已有截图
        for (final snap in snapshots) {
          _imagePaths[snap.filterLevel] = snap.imagePath;
          _annotationCtrls[snap.filterLevel]!.text = snap.annotation;
        }

        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载交易数据失败：$e'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _openPriceCtrl.dispose();
    _lotsCtrl.dispose();
    _stopLossCtrl.dispose();
    _takeProfitCtrl.dispose();
    _notesCtrl.dispose();
    _entryReasonCtrl.dispose();
    for (final c in _annotationCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _saveTrade() async {
    if (_isSaving) return;
    final openPrice = double.tryParse(_openPriceCtrl.text);
    final lots = int.tryParse(_lotsCtrl.text);
    if (openPrice == null || lots == null || lots <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请填写完整的开仓价格和手数')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final tradesDao = ref.read(tradesDaoProvider);
      final snapshotsDao = ref.read(snapshotsDaoProvider);
      final symbolInfo = kFuturesSymbols[_selectedSymbol];

      final int tradeId;
      if (_isEditMode && _editTrade != null) {
        // ── 编辑模式：更新已有记录 ──
        final updated = _editTrade!.copyWith(
          symbol: _selectedSymbol,
          contract: _contract,
          exchange: symbolInfo?.exchange ?? _editTrade!.exchange,
          direction: _direction == TradeDirection.long ? 'long' : 'short',
          openPrice: openPrice,
          lots: lots,
          stopLoss: _stopLossCtrl.text.isNotEmpty
              ? drift.Value(double.tryParse(_stopLossCtrl.text))
              : const drift.Value.absent(),
          takeProfit: _takeProfitCtrl.text.isNotEmpty
              ? drift.Value(double.tryParse(_takeProfitCtrl.text))
              : const drift.Value.absent(),
          signalScore: _signalScore,
          notes: _notesCtrl.text,
          entryReason: _entryReasonCtrl.text,
          updatedAt: DateTime.now(),
        );
        await tradesDao.updateTrade(updated);
        tradeId = _editTrade!.id;

        // ── 若已平仓，重算所有平仓记录的 pnl ──
        if (_editTrade!.status == 'closed') {
          final closeRecordsDao = ref.read(closeRecordsDaoProvider);
          final closeRecords =
              await closeRecordsDao.getCloseRecordsByTrade(tradeId);
          final isLong = _direction == TradeDirection.long;
          final symbolInfo = kFuturesSymbols[_selectedSymbol];
          final multiplier = symbolInfo?.multiplier ?? 1.0;

          for (final cr in closeRecords) {
            final priceDiff = isLong
                ? cr.closePrice - openPrice
                : openPrice - cr.closePrice;
            final newPnl = priceDiff * multiplier * cr.closeLots;
            if ((newPnl - cr.pnl).abs() > 0.01) {
              await closeRecordsDao.updateCloseRecord(cr.copyWith(pnl: newPnl));
            }
          }
        }
      } else {
        // ── 新建模式 ──
        tradeId = await tradesDao.insertTrade(
          TradeRecordsCompanion.insert(
            symbol: _selectedSymbol,
            contract: _contract,
            exchange: symbolInfo?.exchange ?? '',
            direction: _direction == TradeDirection.long ? 'long' : 'short',
            openPrice: openPrice,
            openTime: DateTime.now(),
            lots: lots,
            stopLoss: _stopLossCtrl.text.isNotEmpty
                ? drift.Value(double.tryParse(_stopLossCtrl.text))
                : const drift.Value.absent(),
            takeProfit: _takeProfitCtrl.text.isNotEmpty
                ? drift.Value(double.tryParse(_takeProfitCtrl.text))
                : const drift.Value.absent(),
            signalScore: drift.Value(_signalScore),
            notes: drift.Value(_notesCtrl.text),
            entryReason: drift.Value(_entryReasonCtrl.text),
          ),
        );
      }

      // ── 保存截图 ──
      // 编辑模式：只处理用户新选的图片（_imagePaths 中非 null 的临时路径）
      // 新建模式：处理所有图片
      for (int level = 1; level <= 3; level++) {
        final imagePath = _imagePaths[level];
        if (imagePath == null) continue;

        // 判断是否需要持久化保存（临时文件 vs 已持久化的路径）
        final isNewImage = imagePath.contains('image_picker') ||
            imagePath.contains('/cache/') ||
            imagePath.startsWith('/data/');
        final String savedPath;
        if (isNewImage) {
          savedPath = await ImageManager.saveForTrade(
            sourcePath: imagePath,
            tradeId: tradeId,
            filterLevel: level,
          );
        } else {
          savedPath = imagePath;
        }

        // 删除同级别旧截图，插入新的
        final oldSnap =
            await snapshotsDao.getSnapshotByLevel(tradeId, level);
        if (oldSnap != null) {
          // 删除旧截图文件
          try {
            final oldFile = File(oldSnap.imagePath);
            if (await oldFile.exists()) await oldFile.delete();
          } catch (_) {}
          await snapshotsDao.deleteSnapshot(oldSnap.id);
        }

        await snapshotsDao.insertSnapshot(
          ChartSnapshotsCompanion.insert(
            tradeId: tradeId,
            filterLevel: level,
            timeframe:
                drift.Value(kFilterTimeframes[level - 1].example),
            imagePath: savedPath,
            annotation:
                drift.Value(_annotationCtrls[level]!.text),
            fileSize: drift.Value(
                await ImageManager.getFileSize(savedPath)),
          ),
        );

        // 更新 _imagePaths 指向持久化路径
        _imagePaths[level] = savedPath;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditMode ? '交易记录已更新' : '交易记录已保存'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败：$e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isClosed = _editTrade?.status == 'closed';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          _isEditMode ? '编辑交易记录' : '新建交易记录',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // 已平仓提示
          if (isClosed)
            Container(
              width: double.infinity,
              color: Colors.orange[50],
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: Colors.orange[700]),
                  const SizedBox(width: 8),
                  const Text(
                    '此交易已平仓，修改开仓价/手数/方向后将自动重算盈亏',
                    style: TextStyle(fontSize: 12, color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
          // 步骤指示器
          _StepIndicator(currentStep: _currentStep),
          // 内容
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                  _Step1BasicInfo(
                  symbol: _selectedSymbol,
                  contract: _contract,
                  direction: _direction,
                  signalScore: _signalScore,
                  openPriceCtrl: _openPriceCtrl,
                  lotsCtrl: _lotsCtrl,
                  stopLossCtrl: _stopLossCtrl,
                  takeProfitCtrl: _takeProfitCtrl,
                  notesCtrl: _notesCtrl,
                  entryReasonCtrl: _entryReasonCtrl,
                  readonly: false,
                  onSymbolChanged: (v) =>
                      setState(() => _selectedSymbol = v),
                  onContractChanged: (v) =>
                      setState(() => _contract = v),
                  onDirectionChanged: (v) =>
                      setState(() => _direction = v),
                  onScoreChanged: (v) =>
                      setState(() => _signalScore = v),
                ),
                _Step2ChartSnapshots(
                  imagePaths: _imagePaths,
                  annotationCtrls: _annotationCtrls,
                  onImageSelected: (level, path) =>
                      setState(() => _imagePaths[level] = path),
                ),
                _Step3Notes(entryReasonCtrl: _entryReasonCtrl),
              ],
            ),
          ),
          // 底部按钮
          _BottomNavButtons(
            currentStep: _currentStep,
            isSaving: _isSaving,
            isEditMode: _isEditMode,
            onNext: _nextStep,
            onPrev: _prevStep,
            onSave: _saveTrade,
          ),
        ],
      ),
    );
  }
}

// ─── 步骤指示器 ───────────────────────────────────────
class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['基本信息', '三重滤网截图', '入场理由'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Expanded(
              child: Container(
                height: 1.5,
                color: i ~/ 2 < currentStep
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[300],
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isActive = stepIndex == currentStep;
          final isDone = stepIndex < currentStep;
          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone
                      ? Colors.green
                      : isActive
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300],
                ),
                child: Center(
                  child: isDone
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[stepIndex],
                style: TextStyle(
                  fontSize: 11,
                  color: isActive
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ─── Step 1: 基本信息 ──────────────────────────────────
class _Step1BasicInfo extends StatelessWidget {
  final String symbol;
  final String contract;
  final TradeDirection direction;
  final int signalScore;
  final TextEditingController openPriceCtrl;
  final TextEditingController lotsCtrl;
  final TextEditingController stopLossCtrl;
  final TextEditingController takeProfitCtrl;
  final TextEditingController notesCtrl;
  final TextEditingController entryReasonCtrl;
  final bool readonly;
  final ValueChanged<String> onSymbolChanged;
  final ValueChanged<String> onContractChanged;
  final ValueChanged<TradeDirection> onDirectionChanged;
  final ValueChanged<int> onScoreChanged;

  const _Step1BasicInfo({
    required this.symbol,
    required this.contract,
    required this.direction,
    required this.signalScore,
    required this.openPriceCtrl,
    required this.lotsCtrl,
    required this.stopLossCtrl,
    required this.takeProfitCtrl,
    required this.notesCtrl,
    required this.entryReasonCtrl,
    this.readonly = false,
    required this.onSymbolChanged,
    required this.onContractChanged,
    required this.onDirectionChanged,
    required this.onScoreChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionCard(
            title: '品种与合约',
            child: Column(
              children: [
                // 品种选择
                DropdownButtonFormField<String>(
                  value: symbol,
                  decoration: const InputDecoration(
                    labelText: '品种',
                    prefixIcon: Icon(Icons.show_chart),
                  ),
                  items: kFuturesSymbols.entries
                      .map((e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(
                                '${e.key}  ${e.value.name} (${e.value.exchange})'),
                          ))
                      .toList(),
                  onChanged: readonly ? null : (v) => onSymbolChanged(v!),
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                // 合约月份
                TextFormField(
                  initialValue: contract,
                  enabled: !readonly,
                  decoration: const InputDecoration(
                    labelText: '合约月份',
                    hintText: '如 2609',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: onContractChanged,
                ),
                // 合约规格信息条
                Builder(builder: (ctx) {
                  final info = kFuturesSymbols[symbol];
                  if (info == null) return const SizedBox.shrink();
                  final exName = kExchangeNames[info.exchange] ?? info.exchange;
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('交易所：$exName',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 2),
                              Text('合约规格：${info.unit}',
                                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('合约乘数：${info.multiplierDesc}',
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF1565C0),
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 2),
                              Text('手续费：${info.feeDesc}',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.orange[700])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 方向选择
          _SectionCard(
            title: '交易方向',
            child: Row(
              children: TradeDirection.values
                  .map((d) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: _DirectionButton(
                            direction: d,
                            isSelected: direction == d,
                            enabled: !readonly,
                            onTap: () => onDirectionChanged(d),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          // 价格信息
          _SectionCard(
            title: '价格与仓位',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: openPriceCtrl,
                        enabled: !readonly,
                        decoration: const InputDecoration(
                          labelText: '开仓价格 *',
                          hintText: '0.00',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: lotsCtrl,
                        enabled: !readonly,
                        decoration: const InputDecoration(
                          labelText: '手数 *',
                          hintText: '1',
                          suffixText: '手',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: stopLossCtrl,
                        decoration: const InputDecoration(
                          labelText: '止损价',
                          hintText: '选填',
                          prefixIcon: Icon(Icons.trending_down,
                              color: Color(0xFF2E7D32)),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: takeProfitCtrl,
                        decoration: const InputDecoration(
                          labelText: '止盈价',
                          hintText: '选填',
                          prefixIcon: Icon(Icons.trending_up,
                              color: Color(0xFFD32F2F)),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 信号强度评分
          _SectionCard(
            title: '三重滤网信号强度',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '综合三个周期的共振强度，星级越高说明信号越强',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (i) => GestureDetector(
                        onTap: () => onScoreChanged(i + 1),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            i < signalScore
                                ? Icons.star
                                : Icons.star_outline,
                            size: 32,
                            color: i < signalScore
                                ? Colors.amber
                                : Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      ['', '弱信号', '较弱', '中等', '较强', '强信号'][signalScore],
                      style: const TextStyle(
                          fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DirectionButton extends StatelessWidget {
  final TradeDirection direction;
  final bool isSelected;
  final bool enabled;
  final VoidCallback onTap;

  const _DirectionButton({
    required this.direction,
    required this.isSelected,
    this.enabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 48,
        decoration: BoxDecoration(
          color: isSelected
              ? direction.color.withValues(alpha: 0.15)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? direction.color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Opacity(
          opacity: enabled ? 1.0 : 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                direction == TradeDirection.long
                    ? Icons.north_east
                    : Icons.south_east,
                color: isSelected ? direction.color : Colors.grey,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                direction.fullLabel,
                style: TextStyle(
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? direction.color : Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Step 2: 三重滤网截图 ──────────────────────────────
class _Step2ChartSnapshots extends StatelessWidget {
  final Map<int, String?> imagePaths;
  final Map<int, TextEditingController> annotationCtrls;
  final Function(int level, String path) onImageSelected;

  const _Step2ChartSnapshots({
    required this.imagePaths,
    required this.annotationCtrls,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700], size: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '请在行情软件（天勤/通达信/文华）截图后上传。\n三张截图分别对应大/中/小三个周期。',
                    style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            3,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ChartSnapshotCard(
                filterLevel: i + 1,
                timeframe: kFilterTimeframes[i],
                imagePath: imagePaths[i + 1],
                annotationCtrl: annotationCtrls[i + 1]!,
                onImageSelected: (path) => onImageSelected(i + 1, path),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartSnapshotCard extends StatelessWidget {
  final int filterLevel;
  final FilterTimeframe timeframe;
  final String? imagePath;
  final TextEditingController annotationCtrl;
  final ValueChanged<String> onImageSelected;

  const _ChartSnapshotCard({
    required this.filterLevel,
    required this.timeframe,
    required this.imagePath,
    required this.annotationCtrl,
    required this.onImageSelected,
  });

  static const _levelColors = [
    Color(0xFF1565C0), // 第一重 - 蓝
    Color(0xFF2E7D32), // 第二重 - 绿
    Color(0xFFE65100), // 第三重 - 橙
  ];

  @override
  Widget build(BuildContext context) {
    final color = _levelColors[filterLevel - 1];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: imagePath != null ? color.withValues(alpha: 0.4) : Colors.grey[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$filterLevel',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timeframe.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${timeframe.description}（${timeframe.example}）',
                        style: const TextStyle(
                            fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                // 替换/删除按钮
                if (imagePath != null) ...[
                  GestureDetector(
                    onTap: () async {
                      final path =
                          await ImageManager.showPickerDialog(context);
                      if (path != null) onImageSelected(path);
                    },
                    child: Icon(Icons.swap_horiz,
                        size: 20, color: color.withValues(alpha: 0.6)),
                  ),
                  const SizedBox(width: 12),
                ],
                if (imagePath != null)
                  const Icon(Icons.check_circle,
                      color: Colors.green, size: 20),
              ],
            ),
          ),
          // 图片区域
          GestureDetector(
            onTap: () async {
              final path = await ImageManager.showPickerDialog(context);
              if (path != null) onImageSelected(path);
            },
            child: imagePath != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    child: Image.file(
                      File(imagePath!),
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 100,
                    color: Colors.grey[50],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined,
                              size: 36, color: color.withValues(alpha: 0.5)),
                          const SizedBox(height: 6),
                          Text(
                            '点击上传K线截图',
                            style: TextStyle(
                                fontSize: 13,
                                color: color.withValues(alpha: 0.6)),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          // 图注输入
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              controller: annotationCtrl,
              decoration: InputDecoration(
                hintText: '输入图注，如：MACD顶背离，方向看空...',
                hintStyle:
                    const TextStyle(fontSize: 12, color: Colors.grey),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              maxLines: 2,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Step 3: 入场理由 ──────────────────────────────────
class _Step3Notes extends StatelessWidget {
  final TextEditingController entryReasonCtrl;
  const _Step3Notes({required this.entryReasonCtrl});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _SectionCard(
        title: '入场理由与策略',
        child: TextFormField(
          controller: entryReasonCtrl,
          decoration: const InputDecoration(
            hintText: '记录入场的核心理由：\n1. 第一重滤网（周线）显示...\n2. 第二重滤网（日线）出现...\n3. 第三重滤网（60分钟）...',
            border: InputBorder.none,
          ),
          maxLines: 12,
          style: const TextStyle(fontSize: 14, height: 1.6),
        ),
      ),
    );
  }
}

// ─── 通用 Section 卡片 ─────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 16, thickness: 0.5),
          child,
        ],
      ),
    );
  }
}

// ─── 底部导航按钮 ──────────────────────────────────────
class _BottomNavButtons extends StatelessWidget {
  final int currentStep;
  final bool isSaving;
  final bool isEditMode;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final VoidCallback onSave;

  const _BottomNavButtons({
    required this.currentStep,
    required this.isSaving,
    this.isEditMode = false,
    required this.onNext,
    required this.onPrev,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, 12 + MediaQuery.of(context).padding.bottom),
      color: Colors.white,
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: onPrev,
                child: const Text('上一步'),
              ),
            ),
          if (currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: currentStep < 2
                ? ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kLongColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('下一步'),
                  )
                : ElevatedButton(
                    onPressed: isSaving ? null : onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                    ),
                    child: isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(isEditMode ? '更新记录' : '保存记录'),
                  ),
          ),
        ],
      ),
    );
  }
}
