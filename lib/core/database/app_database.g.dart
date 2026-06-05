// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TradeRecordsTable extends TradeRecords
    with TableInfo<$TradeRecordsTable, TradeRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TradeRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
      'symbol', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _contractMeta =
      const VerificationMeta('contract');
  @override
  late final GeneratedColumn<String> contract = GeneratedColumn<String>(
      'contract', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 6),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _exchangeMeta =
      const VerificationMeta('exchange');
  @override
  late final GeneratedColumn<String> exchange = GeneratedColumn<String>(
      'exchange', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
      'direction', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 5),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _openPriceMeta =
      const VerificationMeta('openPrice');
  @override
  late final GeneratedColumn<double> openPrice = GeneratedColumn<double>(
      'open_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _openTimeMeta =
      const VerificationMeta('openTime');
  @override
  late final GeneratedColumn<DateTime> openTime = GeneratedColumn<DateTime>(
      'open_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lotsMeta = const VerificationMeta('lots');
  @override
  late final GeneratedColumn<int> lots = GeneratedColumn<int>(
      'lots', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stopLossMeta =
      const VerificationMeta('stopLoss');
  @override
  late final GeneratedColumn<double> stopLoss = GeneratedColumn<double>(
      'stop_loss', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _takeProfitMeta =
      const VerificationMeta('takeProfit');
  @override
  late final GeneratedColumn<double> takeProfit = GeneratedColumn<double>(
      'take_profit', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('open'));
  static const VerificationMeta _signalScoreMeta =
      const VerificationMeta('signalScore');
  @override
  late final GeneratedColumn<int> signalScore = GeneratedColumn<int>(
      'signal_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _entryReasonMeta =
      const VerificationMeta('entryReason');
  @override
  late final GeneratedColumn<String> entryReason = GeneratedColumn<String>(
      'entry_reason', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        symbol,
        contract,
        exchange,
        direction,
        openPrice,
        openTime,
        lots,
        stopLoss,
        takeProfit,
        status,
        signalScore,
        notes,
        entryReason,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trade_records';
  @override
  VerificationContext validateIntegrity(Insertable<TradeRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('symbol')) {
      context.handle(_symbolMeta,
          symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta));
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('contract')) {
      context.handle(_contractMeta,
          contract.isAcceptableOrUnknown(data['contract']!, _contractMeta));
    } else if (isInserting) {
      context.missing(_contractMeta);
    }
    if (data.containsKey('exchange')) {
      context.handle(_exchangeMeta,
          exchange.isAcceptableOrUnknown(data['exchange']!, _exchangeMeta));
    } else if (isInserting) {
      context.missing(_exchangeMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('open_price')) {
      context.handle(_openPriceMeta,
          openPrice.isAcceptableOrUnknown(data['open_price']!, _openPriceMeta));
    } else if (isInserting) {
      context.missing(_openPriceMeta);
    }
    if (data.containsKey('open_time')) {
      context.handle(_openTimeMeta,
          openTime.isAcceptableOrUnknown(data['open_time']!, _openTimeMeta));
    } else if (isInserting) {
      context.missing(_openTimeMeta);
    }
    if (data.containsKey('lots')) {
      context.handle(
          _lotsMeta, lots.isAcceptableOrUnknown(data['lots']!, _lotsMeta));
    } else if (isInserting) {
      context.missing(_lotsMeta);
    }
    if (data.containsKey('stop_loss')) {
      context.handle(_stopLossMeta,
          stopLoss.isAcceptableOrUnknown(data['stop_loss']!, _stopLossMeta));
    }
    if (data.containsKey('take_profit')) {
      context.handle(
          _takeProfitMeta,
          takeProfit.isAcceptableOrUnknown(
              data['take_profit']!, _takeProfitMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('signal_score')) {
      context.handle(
          _signalScoreMeta,
          signalScore.isAcceptableOrUnknown(
              data['signal_score']!, _signalScoreMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('entry_reason')) {
      context.handle(
          _entryReasonMeta,
          entryReason.isAcceptableOrUnknown(
              data['entry_reason']!, _entryReasonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TradeRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TradeRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      symbol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symbol'])!,
      contract: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract'])!,
      exchange: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exchange'])!,
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direction'])!,
      openPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}open_price'])!,
      openTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}open_time'])!,
      lots: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lots'])!,
      stopLoss: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stop_loss']),
      takeProfit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}take_profit']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      signalScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}signal_score'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      entryReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_reason'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TradeRecordsTable createAlias(String alias) {
    return $TradeRecordsTable(attachedDatabase, alias);
  }
}

class TradeRecord extends DataClass implements Insertable<TradeRecord> {
  final int id;

  /// 品种代码，如 JD / LH / C / M
  final String symbol;

  /// 合约月份，如 2601 / 2609
  final String contract;

  /// 交易所，如 DCE / CZCE / SHFE / CFFEX
  final String exchange;

  /// 方向：long / short
  final String direction;

  /// 开仓价格
  final double openPrice;

  /// 开仓时间
  final DateTime openTime;

  /// 手数
  final int lots;

  /// 止损价（可为空）
  final double? stopLoss;

  /// 止盈价（可为空）
  final double? takeProfit;

  /// 状态：open / closed / cancelled
  final String status;

  /// 三重滤网信号强度评分 1-5
  final int signalScore;

  /// 开仓备注
  final String notes;

  /// 入场理由
  final String entryReason;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const TradeRecord(
      {required this.id,
      required this.symbol,
      required this.contract,
      required this.exchange,
      required this.direction,
      required this.openPrice,
      required this.openTime,
      required this.lots,
      this.stopLoss,
      this.takeProfit,
      required this.status,
      required this.signalScore,
      required this.notes,
      required this.entryReason,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['symbol'] = Variable<String>(symbol);
    map['contract'] = Variable<String>(contract);
    map['exchange'] = Variable<String>(exchange);
    map['direction'] = Variable<String>(direction);
    map['open_price'] = Variable<double>(openPrice);
    map['open_time'] = Variable<DateTime>(openTime);
    map['lots'] = Variable<int>(lots);
    if (!nullToAbsent || stopLoss != null) {
      map['stop_loss'] = Variable<double>(stopLoss);
    }
    if (!nullToAbsent || takeProfit != null) {
      map['take_profit'] = Variable<double>(takeProfit);
    }
    map['status'] = Variable<String>(status);
    map['signal_score'] = Variable<int>(signalScore);
    map['notes'] = Variable<String>(notes);
    map['entry_reason'] = Variable<String>(entryReason);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TradeRecordsCompanion toCompanion(bool nullToAbsent) {
    return TradeRecordsCompanion(
      id: Value(id),
      symbol: Value(symbol),
      contract: Value(contract),
      exchange: Value(exchange),
      direction: Value(direction),
      openPrice: Value(openPrice),
      openTime: Value(openTime),
      lots: Value(lots),
      stopLoss: stopLoss == null && nullToAbsent
          ? const Value.absent()
          : Value(stopLoss),
      takeProfit: takeProfit == null && nullToAbsent
          ? const Value.absent()
          : Value(takeProfit),
      status: Value(status),
      signalScore: Value(signalScore),
      notes: Value(notes),
      entryReason: Value(entryReason),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TradeRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TradeRecord(
      id: serializer.fromJson<int>(json['id']),
      symbol: serializer.fromJson<String>(json['symbol']),
      contract: serializer.fromJson<String>(json['contract']),
      exchange: serializer.fromJson<String>(json['exchange']),
      direction: serializer.fromJson<String>(json['direction']),
      openPrice: serializer.fromJson<double>(json['openPrice']),
      openTime: serializer.fromJson<DateTime>(json['openTime']),
      lots: serializer.fromJson<int>(json['lots']),
      stopLoss: serializer.fromJson<double?>(json['stopLoss']),
      takeProfit: serializer.fromJson<double?>(json['takeProfit']),
      status: serializer.fromJson<String>(json['status']),
      signalScore: serializer.fromJson<int>(json['signalScore']),
      notes: serializer.fromJson<String>(json['notes']),
      entryReason: serializer.fromJson<String>(json['entryReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'symbol': serializer.toJson<String>(symbol),
      'contract': serializer.toJson<String>(contract),
      'exchange': serializer.toJson<String>(exchange),
      'direction': serializer.toJson<String>(direction),
      'openPrice': serializer.toJson<double>(openPrice),
      'openTime': serializer.toJson<DateTime>(openTime),
      'lots': serializer.toJson<int>(lots),
      'stopLoss': serializer.toJson<double?>(stopLoss),
      'takeProfit': serializer.toJson<double?>(takeProfit),
      'status': serializer.toJson<String>(status),
      'signalScore': serializer.toJson<int>(signalScore),
      'notes': serializer.toJson<String>(notes),
      'entryReason': serializer.toJson<String>(entryReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TradeRecord copyWith(
          {int? id,
          String? symbol,
          String? contract,
          String? exchange,
          String? direction,
          double? openPrice,
          DateTime? openTime,
          int? lots,
          Value<double?> stopLoss = const Value.absent(),
          Value<double?> takeProfit = const Value.absent(),
          String? status,
          int? signalScore,
          String? notes,
          String? entryReason,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TradeRecord(
        id: id ?? this.id,
        symbol: symbol ?? this.symbol,
        contract: contract ?? this.contract,
        exchange: exchange ?? this.exchange,
        direction: direction ?? this.direction,
        openPrice: openPrice ?? this.openPrice,
        openTime: openTime ?? this.openTime,
        lots: lots ?? this.lots,
        stopLoss: stopLoss.present ? stopLoss.value : this.stopLoss,
        takeProfit: takeProfit.present ? takeProfit.value : this.takeProfit,
        status: status ?? this.status,
        signalScore: signalScore ?? this.signalScore,
        notes: notes ?? this.notes,
        entryReason: entryReason ?? this.entryReason,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TradeRecord copyWithCompanion(TradeRecordsCompanion data) {
    return TradeRecord(
      id: data.id.present ? data.id.value : this.id,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      contract: data.contract.present ? data.contract.value : this.contract,
      exchange: data.exchange.present ? data.exchange.value : this.exchange,
      direction: data.direction.present ? data.direction.value : this.direction,
      openPrice: data.openPrice.present ? data.openPrice.value : this.openPrice,
      openTime: data.openTime.present ? data.openTime.value : this.openTime,
      lots: data.lots.present ? data.lots.value : this.lots,
      stopLoss: data.stopLoss.present ? data.stopLoss.value : this.stopLoss,
      takeProfit:
          data.takeProfit.present ? data.takeProfit.value : this.takeProfit,
      status: data.status.present ? data.status.value : this.status,
      signalScore:
          data.signalScore.present ? data.signalScore.value : this.signalScore,
      notes: data.notes.present ? data.notes.value : this.notes,
      entryReason:
          data.entryReason.present ? data.entryReason.value : this.entryReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TradeRecord(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('contract: $contract, ')
          ..write('exchange: $exchange, ')
          ..write('direction: $direction, ')
          ..write('openPrice: $openPrice, ')
          ..write('openTime: $openTime, ')
          ..write('lots: $lots, ')
          ..write('stopLoss: $stopLoss, ')
          ..write('takeProfit: $takeProfit, ')
          ..write('status: $status, ')
          ..write('signalScore: $signalScore, ')
          ..write('notes: $notes, ')
          ..write('entryReason: $entryReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      symbol,
      contract,
      exchange,
      direction,
      openPrice,
      openTime,
      lots,
      stopLoss,
      takeProfit,
      status,
      signalScore,
      notes,
      entryReason,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TradeRecord &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.contract == this.contract &&
          other.exchange == this.exchange &&
          other.direction == this.direction &&
          other.openPrice == this.openPrice &&
          other.openTime == this.openTime &&
          other.lots == this.lots &&
          other.stopLoss == this.stopLoss &&
          other.takeProfit == this.takeProfit &&
          other.status == this.status &&
          other.signalScore == this.signalScore &&
          other.notes == this.notes &&
          other.entryReason == this.entryReason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TradeRecordsCompanion extends UpdateCompanion<TradeRecord> {
  final Value<int> id;
  final Value<String> symbol;
  final Value<String> contract;
  final Value<String> exchange;
  final Value<String> direction;
  final Value<double> openPrice;
  final Value<DateTime> openTime;
  final Value<int> lots;
  final Value<double?> stopLoss;
  final Value<double?> takeProfit;
  final Value<String> status;
  final Value<int> signalScore;
  final Value<String> notes;
  final Value<String> entryReason;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TradeRecordsCompanion({
    this.id = const Value.absent(),
    this.symbol = const Value.absent(),
    this.contract = const Value.absent(),
    this.exchange = const Value.absent(),
    this.direction = const Value.absent(),
    this.openPrice = const Value.absent(),
    this.openTime = const Value.absent(),
    this.lots = const Value.absent(),
    this.stopLoss = const Value.absent(),
    this.takeProfit = const Value.absent(),
    this.status = const Value.absent(),
    this.signalScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.entryReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TradeRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String symbol,
    required String contract,
    required String exchange,
    required String direction,
    required double openPrice,
    required DateTime openTime,
    required int lots,
    this.stopLoss = const Value.absent(),
    this.takeProfit = const Value.absent(),
    this.status = const Value.absent(),
    this.signalScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.entryReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : symbol = Value(symbol),
        contract = Value(contract),
        exchange = Value(exchange),
        direction = Value(direction),
        openPrice = Value(openPrice),
        openTime = Value(openTime),
        lots = Value(lots);
  static Insertable<TradeRecord> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? contract,
    Expression<String>? exchange,
    Expression<String>? direction,
    Expression<double>? openPrice,
    Expression<DateTime>? openTime,
    Expression<int>? lots,
    Expression<double>? stopLoss,
    Expression<double>? takeProfit,
    Expression<String>? status,
    Expression<int>? signalScore,
    Expression<String>? notes,
    Expression<String>? entryReason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (symbol != null) 'symbol': symbol,
      if (contract != null) 'contract': contract,
      if (exchange != null) 'exchange': exchange,
      if (direction != null) 'direction': direction,
      if (openPrice != null) 'open_price': openPrice,
      if (openTime != null) 'open_time': openTime,
      if (lots != null) 'lots': lots,
      if (stopLoss != null) 'stop_loss': stopLoss,
      if (takeProfit != null) 'take_profit': takeProfit,
      if (status != null) 'status': status,
      if (signalScore != null) 'signal_score': signalScore,
      if (notes != null) 'notes': notes,
      if (entryReason != null) 'entry_reason': entryReason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TradeRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? symbol,
      Value<String>? contract,
      Value<String>? exchange,
      Value<String>? direction,
      Value<double>? openPrice,
      Value<DateTime>? openTime,
      Value<int>? lots,
      Value<double?>? stopLoss,
      Value<double?>? takeProfit,
      Value<String>? status,
      Value<int>? signalScore,
      Value<String>? notes,
      Value<String>? entryReason,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TradeRecordsCompanion(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      contract: contract ?? this.contract,
      exchange: exchange ?? this.exchange,
      direction: direction ?? this.direction,
      openPrice: openPrice ?? this.openPrice,
      openTime: openTime ?? this.openTime,
      lots: lots ?? this.lots,
      stopLoss: stopLoss ?? this.stopLoss,
      takeProfit: takeProfit ?? this.takeProfit,
      status: status ?? this.status,
      signalScore: signalScore ?? this.signalScore,
      notes: notes ?? this.notes,
      entryReason: entryReason ?? this.entryReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (contract.present) {
      map['contract'] = Variable<String>(contract.value);
    }
    if (exchange.present) {
      map['exchange'] = Variable<String>(exchange.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (openPrice.present) {
      map['open_price'] = Variable<double>(openPrice.value);
    }
    if (openTime.present) {
      map['open_time'] = Variable<DateTime>(openTime.value);
    }
    if (lots.present) {
      map['lots'] = Variable<int>(lots.value);
    }
    if (stopLoss.present) {
      map['stop_loss'] = Variable<double>(stopLoss.value);
    }
    if (takeProfit.present) {
      map['take_profit'] = Variable<double>(takeProfit.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (signalScore.present) {
      map['signal_score'] = Variable<int>(signalScore.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (entryReason.present) {
      map['entry_reason'] = Variable<String>(entryReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TradeRecordsCompanion(')
          ..write('id: $id, ')
          ..write('symbol: $symbol, ')
          ..write('contract: $contract, ')
          ..write('exchange: $exchange, ')
          ..write('direction: $direction, ')
          ..write('openPrice: $openPrice, ')
          ..write('openTime: $openTime, ')
          ..write('lots: $lots, ')
          ..write('stopLoss: $stopLoss, ')
          ..write('takeProfit: $takeProfit, ')
          ..write('status: $status, ')
          ..write('signalScore: $signalScore, ')
          ..write('notes: $notes, ')
          ..write('entryReason: $entryReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChartSnapshotsTable extends ChartSnapshots
    with TableInfo<$ChartSnapshotsTable, ChartSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChartSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tradeIdMeta =
      const VerificationMeta('tradeId');
  @override
  late final GeneratedColumn<int> tradeId = GeneratedColumn<int>(
      'trade_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES trade_records (id) ON DELETE CASCADE'));
  static const VerificationMeta _filterLevelMeta =
      const VerificationMeta('filterLevel');
  @override
  late final GeneratedColumn<int> filterLevel = GeneratedColumn<int>(
      'filter_level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timeframeMeta =
      const VerificationMeta('timeframe');
  @override
  late final GeneratedColumn<String> timeframe = GeneratedColumn<String>(
      'timeframe', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _capturedAtMeta =
      const VerificationMeta('capturedAt');
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
      'captured_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _annotationMeta =
      const VerificationMeta('annotation');
  @override
  late final GeneratedColumn<String> annotation = GeneratedColumn<String>(
      'annotation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _fileSizeMeta =
      const VerificationMeta('fileSize');
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
      'file_size', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tradeId,
        filterLevel,
        timeframe,
        imagePath,
        capturedAt,
        annotation,
        fileSize
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chart_snapshots';
  @override
  VerificationContext validateIntegrity(Insertable<ChartSnapshot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trade_id')) {
      context.handle(_tradeIdMeta,
          tradeId.isAcceptableOrUnknown(data['trade_id']!, _tradeIdMeta));
    } else if (isInserting) {
      context.missing(_tradeIdMeta);
    }
    if (data.containsKey('filter_level')) {
      context.handle(
          _filterLevelMeta,
          filterLevel.isAcceptableOrUnknown(
              data['filter_level']!, _filterLevelMeta));
    } else if (isInserting) {
      context.missing(_filterLevelMeta);
    }
    if (data.containsKey('timeframe')) {
      context.handle(_timeframeMeta,
          timeframe.isAcceptableOrUnknown(data['timeframe']!, _timeframeMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('captured_at')) {
      context.handle(
          _capturedAtMeta,
          capturedAt.isAcceptableOrUnknown(
              data['captured_at']!, _capturedAtMeta));
    }
    if (data.containsKey('annotation')) {
      context.handle(
          _annotationMeta,
          annotation.isAcceptableOrUnknown(
              data['annotation']!, _annotationMeta));
    }
    if (data.containsKey('file_size')) {
      context.handle(_fileSizeMeta,
          fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChartSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChartSnapshot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tradeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trade_id'])!,
      filterLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}filter_level'])!,
      timeframe: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timeframe'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      capturedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}captured_at'])!,
      annotation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}annotation'])!,
      fileSize: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_size'])!,
    );
  }

  @override
  $ChartSnapshotsTable createAlias(String alias) {
    return $ChartSnapshotsTable(attachedDatabase, alias);
  }
}

class ChartSnapshot extends DataClass implements Insertable<ChartSnapshot> {
  final int id;

  /// 关联交易ID
  final int tradeId;

  /// 滤网级别：1 / 2 / 3
  final int filterLevel;

  /// 时间周期描述，如 "weekly" / "daily" / "60min" / "15min"
  final String timeframe;

  /// 本地图片文件路径（相对于App文档目录）
  final String imagePath;

  /// 截图时间（用户操作时间，不是行情时间）
  final DateTime capturedAt;

  /// 图注（用户对这张图的分析说明）
  final String annotation;

  /// 图片文件大小（字节），用于统计存储用量
  final int fileSize;
  const ChartSnapshot(
      {required this.id,
      required this.tradeId,
      required this.filterLevel,
      required this.timeframe,
      required this.imagePath,
      required this.capturedAt,
      required this.annotation,
      required this.fileSize});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trade_id'] = Variable<int>(tradeId);
    map['filter_level'] = Variable<int>(filterLevel);
    map['timeframe'] = Variable<String>(timeframe);
    map['image_path'] = Variable<String>(imagePath);
    map['captured_at'] = Variable<DateTime>(capturedAt);
    map['annotation'] = Variable<String>(annotation);
    map['file_size'] = Variable<int>(fileSize);
    return map;
  }

  ChartSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return ChartSnapshotsCompanion(
      id: Value(id),
      tradeId: Value(tradeId),
      filterLevel: Value(filterLevel),
      timeframe: Value(timeframe),
      imagePath: Value(imagePath),
      capturedAt: Value(capturedAt),
      annotation: Value(annotation),
      fileSize: Value(fileSize),
    );
  }

  factory ChartSnapshot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChartSnapshot(
      id: serializer.fromJson<int>(json['id']),
      tradeId: serializer.fromJson<int>(json['tradeId']),
      filterLevel: serializer.fromJson<int>(json['filterLevel']),
      timeframe: serializer.fromJson<String>(json['timeframe']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      capturedAt: serializer.fromJson<DateTime>(json['capturedAt']),
      annotation: serializer.fromJson<String>(json['annotation']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tradeId': serializer.toJson<int>(tradeId),
      'filterLevel': serializer.toJson<int>(filterLevel),
      'timeframe': serializer.toJson<String>(timeframe),
      'imagePath': serializer.toJson<String>(imagePath),
      'capturedAt': serializer.toJson<DateTime>(capturedAt),
      'annotation': serializer.toJson<String>(annotation),
      'fileSize': serializer.toJson<int>(fileSize),
    };
  }

  ChartSnapshot copyWith(
          {int? id,
          int? tradeId,
          int? filterLevel,
          String? timeframe,
          String? imagePath,
          DateTime? capturedAt,
          String? annotation,
          int? fileSize}) =>
      ChartSnapshot(
        id: id ?? this.id,
        tradeId: tradeId ?? this.tradeId,
        filterLevel: filterLevel ?? this.filterLevel,
        timeframe: timeframe ?? this.timeframe,
        imagePath: imagePath ?? this.imagePath,
        capturedAt: capturedAt ?? this.capturedAt,
        annotation: annotation ?? this.annotation,
        fileSize: fileSize ?? this.fileSize,
      );
  ChartSnapshot copyWithCompanion(ChartSnapshotsCompanion data) {
    return ChartSnapshot(
      id: data.id.present ? data.id.value : this.id,
      tradeId: data.tradeId.present ? data.tradeId.value : this.tradeId,
      filterLevel:
          data.filterLevel.present ? data.filterLevel.value : this.filterLevel,
      timeframe: data.timeframe.present ? data.timeframe.value : this.timeframe,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      capturedAt:
          data.capturedAt.present ? data.capturedAt.value : this.capturedAt,
      annotation:
          data.annotation.present ? data.annotation.value : this.annotation,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChartSnapshot(')
          ..write('id: $id, ')
          ..write('tradeId: $tradeId, ')
          ..write('filterLevel: $filterLevel, ')
          ..write('timeframe: $timeframe, ')
          ..write('imagePath: $imagePath, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('annotation: $annotation, ')
          ..write('fileSize: $fileSize')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tradeId, filterLevel, timeframe,
      imagePath, capturedAt, annotation, fileSize);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChartSnapshot &&
          other.id == this.id &&
          other.tradeId == this.tradeId &&
          other.filterLevel == this.filterLevel &&
          other.timeframe == this.timeframe &&
          other.imagePath == this.imagePath &&
          other.capturedAt == this.capturedAt &&
          other.annotation == this.annotation &&
          other.fileSize == this.fileSize);
}

class ChartSnapshotsCompanion extends UpdateCompanion<ChartSnapshot> {
  final Value<int> id;
  final Value<int> tradeId;
  final Value<int> filterLevel;
  final Value<String> timeframe;
  final Value<String> imagePath;
  final Value<DateTime> capturedAt;
  final Value<String> annotation;
  final Value<int> fileSize;
  const ChartSnapshotsCompanion({
    this.id = const Value.absent(),
    this.tradeId = const Value.absent(),
    this.filterLevel = const Value.absent(),
    this.timeframe = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.annotation = const Value.absent(),
    this.fileSize = const Value.absent(),
  });
  ChartSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required int tradeId,
    required int filterLevel,
    this.timeframe = const Value.absent(),
    required String imagePath,
    this.capturedAt = const Value.absent(),
    this.annotation = const Value.absent(),
    this.fileSize = const Value.absent(),
  })  : tradeId = Value(tradeId),
        filterLevel = Value(filterLevel),
        imagePath = Value(imagePath);
  static Insertable<ChartSnapshot> custom({
    Expression<int>? id,
    Expression<int>? tradeId,
    Expression<int>? filterLevel,
    Expression<String>? timeframe,
    Expression<String>? imagePath,
    Expression<DateTime>? capturedAt,
    Expression<String>? annotation,
    Expression<int>? fileSize,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tradeId != null) 'trade_id': tradeId,
      if (filterLevel != null) 'filter_level': filterLevel,
      if (timeframe != null) 'timeframe': timeframe,
      if (imagePath != null) 'image_path': imagePath,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (annotation != null) 'annotation': annotation,
      if (fileSize != null) 'file_size': fileSize,
    });
  }

  ChartSnapshotsCompanion copyWith(
      {Value<int>? id,
      Value<int>? tradeId,
      Value<int>? filterLevel,
      Value<String>? timeframe,
      Value<String>? imagePath,
      Value<DateTime>? capturedAt,
      Value<String>? annotation,
      Value<int>? fileSize}) {
    return ChartSnapshotsCompanion(
      id: id ?? this.id,
      tradeId: tradeId ?? this.tradeId,
      filterLevel: filterLevel ?? this.filterLevel,
      timeframe: timeframe ?? this.timeframe,
      imagePath: imagePath ?? this.imagePath,
      capturedAt: capturedAt ?? this.capturedAt,
      annotation: annotation ?? this.annotation,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tradeId.present) {
      map['trade_id'] = Variable<int>(tradeId.value);
    }
    if (filterLevel.present) {
      map['filter_level'] = Variable<int>(filterLevel.value);
    }
    if (timeframe.present) {
      map['timeframe'] = Variable<String>(timeframe.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (annotation.present) {
      map['annotation'] = Variable<String>(annotation.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChartSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('tradeId: $tradeId, ')
          ..write('filterLevel: $filterLevel, ')
          ..write('timeframe: $timeframe, ')
          ..write('imagePath: $imagePath, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('annotation: $annotation, ')
          ..write('fileSize: $fileSize')
          ..write(')'))
        .toString();
  }
}

class $CloseRecordsTable extends CloseRecords
    with TableInfo<$CloseRecordsTable, CloseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CloseRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tradeIdMeta =
      const VerificationMeta('tradeId');
  @override
  late final GeneratedColumn<int> tradeId = GeneratedColumn<int>(
      'trade_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES trade_records (id) ON DELETE CASCADE'));
  static const VerificationMeta _closePriceMeta =
      const VerificationMeta('closePrice');
  @override
  late final GeneratedColumn<double> closePrice = GeneratedColumn<double>(
      'close_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _closeTimeMeta =
      const VerificationMeta('closeTime');
  @override
  late final GeneratedColumn<DateTime> closeTime = GeneratedColumn<DateTime>(
      'close_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _closeLotsMeta =
      const VerificationMeta('closeLots');
  @override
  late final GeneratedColumn<int> closeLots = GeneratedColumn<int>(
      'close_lots', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pnlMeta = const VerificationMeta('pnl');
  @override
  late final GeneratedColumn<double> pnl = GeneratedColumn<double>(
      'pnl', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _commissionMeta =
      const VerificationMeta('commission');
  @override
  late final GeneratedColumn<double> commission = GeneratedColumn<double>(
      'commission', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _slipPointsMeta =
      const VerificationMeta('slipPoints');
  @override
  late final GeneratedColumn<double> slipPoints = GeneratedColumn<double>(
      'slip_points', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _closeReasonMeta =
      const VerificationMeta('closeReason');
  @override
  late final GeneratedColumn<String> closeReason = GeneratedColumn<String>(
      'close_reason', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manual'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tradeId,
        closePrice,
        closeTime,
        closeLots,
        pnl,
        commission,
        slipPoints,
        closeReason,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'close_records';
  @override
  VerificationContext validateIntegrity(Insertable<CloseRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trade_id')) {
      context.handle(_tradeIdMeta,
          tradeId.isAcceptableOrUnknown(data['trade_id']!, _tradeIdMeta));
    } else if (isInserting) {
      context.missing(_tradeIdMeta);
    }
    if (data.containsKey('close_price')) {
      context.handle(
          _closePriceMeta,
          closePrice.isAcceptableOrUnknown(
              data['close_price']!, _closePriceMeta));
    } else if (isInserting) {
      context.missing(_closePriceMeta);
    }
    if (data.containsKey('close_time')) {
      context.handle(_closeTimeMeta,
          closeTime.isAcceptableOrUnknown(data['close_time']!, _closeTimeMeta));
    } else if (isInserting) {
      context.missing(_closeTimeMeta);
    }
    if (data.containsKey('close_lots')) {
      context.handle(_closeLotsMeta,
          closeLots.isAcceptableOrUnknown(data['close_lots']!, _closeLotsMeta));
    } else if (isInserting) {
      context.missing(_closeLotsMeta);
    }
    if (data.containsKey('pnl')) {
      context.handle(
          _pnlMeta, pnl.isAcceptableOrUnknown(data['pnl']!, _pnlMeta));
    } else if (isInserting) {
      context.missing(_pnlMeta);
    }
    if (data.containsKey('commission')) {
      context.handle(
          _commissionMeta,
          commission.isAcceptableOrUnknown(
              data['commission']!, _commissionMeta));
    }
    if (data.containsKey('slip_points')) {
      context.handle(
          _slipPointsMeta,
          slipPoints.isAcceptableOrUnknown(
              data['slip_points']!, _slipPointsMeta));
    }
    if (data.containsKey('close_reason')) {
      context.handle(
          _closeReasonMeta,
          closeReason.isAcceptableOrUnknown(
              data['close_reason']!, _closeReasonMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CloseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CloseRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tradeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trade_id'])!,
      closePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}close_price'])!,
      closeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}close_time'])!,
      closeLots: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}close_lots'])!,
      pnl: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pnl'])!,
      commission: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}commission'])!,
      slipPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}slip_points'])!,
      closeReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}close_reason'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CloseRecordsTable createAlias(String alias) {
    return $CloseRecordsTable(attachedDatabase, alias);
  }
}

class CloseRecord extends DataClass implements Insertable<CloseRecord> {
  final int id;

  /// 关联交易ID
  final int tradeId;

  /// 平仓价格
  final double closePrice;

  /// 平仓时间
  final DateTime closeTime;

  /// 本次平仓手数
  final int closeLots;

  /// 盈亏金额（元），正数为盈利，负数为亏损
  final double pnl;

  /// 手续费（元）
  final double commission;

  /// 滑点损耗（点数）
  final double slipPoints;

  /// 平仓原因：stopLoss / takeProfit / manual / reversal / expiry
  final String closeReason;

  /// 平仓备注
  final String notes;

  /// 记录创建时间
  final DateTime createdAt;
  const CloseRecord(
      {required this.id,
      required this.tradeId,
      required this.closePrice,
      required this.closeTime,
      required this.closeLots,
      required this.pnl,
      required this.commission,
      required this.slipPoints,
      required this.closeReason,
      required this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trade_id'] = Variable<int>(tradeId);
    map['close_price'] = Variable<double>(closePrice);
    map['close_time'] = Variable<DateTime>(closeTime);
    map['close_lots'] = Variable<int>(closeLots);
    map['pnl'] = Variable<double>(pnl);
    map['commission'] = Variable<double>(commission);
    map['slip_points'] = Variable<double>(slipPoints);
    map['close_reason'] = Variable<String>(closeReason);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CloseRecordsCompanion toCompanion(bool nullToAbsent) {
    return CloseRecordsCompanion(
      id: Value(id),
      tradeId: Value(tradeId),
      closePrice: Value(closePrice),
      closeTime: Value(closeTime),
      closeLots: Value(closeLots),
      pnl: Value(pnl),
      commission: Value(commission),
      slipPoints: Value(slipPoints),
      closeReason: Value(closeReason),
      notes: Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory CloseRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CloseRecord(
      id: serializer.fromJson<int>(json['id']),
      tradeId: serializer.fromJson<int>(json['tradeId']),
      closePrice: serializer.fromJson<double>(json['closePrice']),
      closeTime: serializer.fromJson<DateTime>(json['closeTime']),
      closeLots: serializer.fromJson<int>(json['closeLots']),
      pnl: serializer.fromJson<double>(json['pnl']),
      commission: serializer.fromJson<double>(json['commission']),
      slipPoints: serializer.fromJson<double>(json['slipPoints']),
      closeReason: serializer.fromJson<String>(json['closeReason']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tradeId': serializer.toJson<int>(tradeId),
      'closePrice': serializer.toJson<double>(closePrice),
      'closeTime': serializer.toJson<DateTime>(closeTime),
      'closeLots': serializer.toJson<int>(closeLots),
      'pnl': serializer.toJson<double>(pnl),
      'commission': serializer.toJson<double>(commission),
      'slipPoints': serializer.toJson<double>(slipPoints),
      'closeReason': serializer.toJson<String>(closeReason),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CloseRecord copyWith(
          {int? id,
          int? tradeId,
          double? closePrice,
          DateTime? closeTime,
          int? closeLots,
          double? pnl,
          double? commission,
          double? slipPoints,
          String? closeReason,
          String? notes,
          DateTime? createdAt}) =>
      CloseRecord(
        id: id ?? this.id,
        tradeId: tradeId ?? this.tradeId,
        closePrice: closePrice ?? this.closePrice,
        closeTime: closeTime ?? this.closeTime,
        closeLots: closeLots ?? this.closeLots,
        pnl: pnl ?? this.pnl,
        commission: commission ?? this.commission,
        slipPoints: slipPoints ?? this.slipPoints,
        closeReason: closeReason ?? this.closeReason,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  CloseRecord copyWithCompanion(CloseRecordsCompanion data) {
    return CloseRecord(
      id: data.id.present ? data.id.value : this.id,
      tradeId: data.tradeId.present ? data.tradeId.value : this.tradeId,
      closePrice:
          data.closePrice.present ? data.closePrice.value : this.closePrice,
      closeTime: data.closeTime.present ? data.closeTime.value : this.closeTime,
      closeLots: data.closeLots.present ? data.closeLots.value : this.closeLots,
      pnl: data.pnl.present ? data.pnl.value : this.pnl,
      commission:
          data.commission.present ? data.commission.value : this.commission,
      slipPoints:
          data.slipPoints.present ? data.slipPoints.value : this.slipPoints,
      closeReason:
          data.closeReason.present ? data.closeReason.value : this.closeReason,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CloseRecord(')
          ..write('id: $id, ')
          ..write('tradeId: $tradeId, ')
          ..write('closePrice: $closePrice, ')
          ..write('closeTime: $closeTime, ')
          ..write('closeLots: $closeLots, ')
          ..write('pnl: $pnl, ')
          ..write('commission: $commission, ')
          ..write('slipPoints: $slipPoints, ')
          ..write('closeReason: $closeReason, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tradeId, closePrice, closeTime, closeLots,
      pnl, commission, slipPoints, closeReason, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CloseRecord &&
          other.id == this.id &&
          other.tradeId == this.tradeId &&
          other.closePrice == this.closePrice &&
          other.closeTime == this.closeTime &&
          other.closeLots == this.closeLots &&
          other.pnl == this.pnl &&
          other.commission == this.commission &&
          other.slipPoints == this.slipPoints &&
          other.closeReason == this.closeReason &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CloseRecordsCompanion extends UpdateCompanion<CloseRecord> {
  final Value<int> id;
  final Value<int> tradeId;
  final Value<double> closePrice;
  final Value<DateTime> closeTime;
  final Value<int> closeLots;
  final Value<double> pnl;
  final Value<double> commission;
  final Value<double> slipPoints;
  final Value<String> closeReason;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  const CloseRecordsCompanion({
    this.id = const Value.absent(),
    this.tradeId = const Value.absent(),
    this.closePrice = const Value.absent(),
    this.closeTime = const Value.absent(),
    this.closeLots = const Value.absent(),
    this.pnl = const Value.absent(),
    this.commission = const Value.absent(),
    this.slipPoints = const Value.absent(),
    this.closeReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CloseRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int tradeId,
    required double closePrice,
    required DateTime closeTime,
    required int closeLots,
    required double pnl,
    this.commission = const Value.absent(),
    this.slipPoints = const Value.absent(),
    this.closeReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : tradeId = Value(tradeId),
        closePrice = Value(closePrice),
        closeTime = Value(closeTime),
        closeLots = Value(closeLots),
        pnl = Value(pnl);
  static Insertable<CloseRecord> custom({
    Expression<int>? id,
    Expression<int>? tradeId,
    Expression<double>? closePrice,
    Expression<DateTime>? closeTime,
    Expression<int>? closeLots,
    Expression<double>? pnl,
    Expression<double>? commission,
    Expression<double>? slipPoints,
    Expression<String>? closeReason,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tradeId != null) 'trade_id': tradeId,
      if (closePrice != null) 'close_price': closePrice,
      if (closeTime != null) 'close_time': closeTime,
      if (closeLots != null) 'close_lots': closeLots,
      if (pnl != null) 'pnl': pnl,
      if (commission != null) 'commission': commission,
      if (slipPoints != null) 'slip_points': slipPoints,
      if (closeReason != null) 'close_reason': closeReason,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CloseRecordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? tradeId,
      Value<double>? closePrice,
      Value<DateTime>? closeTime,
      Value<int>? closeLots,
      Value<double>? pnl,
      Value<double>? commission,
      Value<double>? slipPoints,
      Value<String>? closeReason,
      Value<String>? notes,
      Value<DateTime>? createdAt}) {
    return CloseRecordsCompanion(
      id: id ?? this.id,
      tradeId: tradeId ?? this.tradeId,
      closePrice: closePrice ?? this.closePrice,
      closeTime: closeTime ?? this.closeTime,
      closeLots: closeLots ?? this.closeLots,
      pnl: pnl ?? this.pnl,
      commission: commission ?? this.commission,
      slipPoints: slipPoints ?? this.slipPoints,
      closeReason: closeReason ?? this.closeReason,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tradeId.present) {
      map['trade_id'] = Variable<int>(tradeId.value);
    }
    if (closePrice.present) {
      map['close_price'] = Variable<double>(closePrice.value);
    }
    if (closeTime.present) {
      map['close_time'] = Variable<DateTime>(closeTime.value);
    }
    if (closeLots.present) {
      map['close_lots'] = Variable<int>(closeLots.value);
    }
    if (pnl.present) {
      map['pnl'] = Variable<double>(pnl.value);
    }
    if (commission.present) {
      map['commission'] = Variable<double>(commission.value);
    }
    if (slipPoints.present) {
      map['slip_points'] = Variable<double>(slipPoints.value);
    }
    if (closeReason.present) {
      map['close_reason'] = Variable<String>(closeReason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CloseRecordsCompanion(')
          ..write('id: $id, ')
          ..write('tradeId: $tradeId, ')
          ..write('closePrice: $closePrice, ')
          ..write('closeTime: $closeTime, ')
          ..write('closeLots: $closeLots, ')
          ..write('pnl: $pnl, ')
          ..write('commission: $commission, ')
          ..write('slipPoints: $slipPoints, ')
          ..write('closeReason: $closeReason, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TradeJournalsTable extends TradeJournals
    with TableInfo<$TradeJournalsTable, TradeJournal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TradeJournalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tradeIdMeta =
      const VerificationMeta('tradeId');
  @override
  late final GeneratedColumn<int> tradeId = GeneratedColumn<int>(
      'trade_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES trade_records (id) ON DELETE CASCADE'));
  static const VerificationMeta _reviewTextMeta =
      const VerificationMeta('reviewText');
  @override
  late final GeneratedColumn<String> reviewText = GeneratedColumn<String>(
      'review_text', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _emotionTagMeta =
      const VerificationMeta('emotionTag');
  @override
  late final GeneratedColumn<String> emotionTag = GeneratedColumn<String>(
      'emotion_tag', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('calm'));
  static const VerificationMeta _disciplineScoreMeta =
      const VerificationMeta('disciplineScore');
  @override
  late final GeneratedColumn<int> disciplineScore = GeneratedColumn<int>(
      'discipline_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _strategyTagsMeta =
      const VerificationMeta('strategyTags');
  @override
  late final GeneratedColumn<String> strategyTags = GeneratedColumn<String>(
      'strategy_tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _mistakesMeta =
      const VerificationMeta('mistakes');
  @override
  late final GeneratedColumn<String> mistakes = GeneratedColumn<String>(
      'mistakes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _improvementsMeta =
      const VerificationMeta('improvements');
  @override
  late final GeneratedColumn<String> improvements = GeneratedColumn<String>(
      'improvements', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tradeId,
        reviewText,
        emotionTag,
        disciplineScore,
        strategyTags,
        mistakes,
        improvements,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trade_journals';
  @override
  VerificationContext validateIntegrity(Insertable<TradeJournal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trade_id')) {
      context.handle(_tradeIdMeta,
          tradeId.isAcceptableOrUnknown(data['trade_id']!, _tradeIdMeta));
    } else if (isInserting) {
      context.missing(_tradeIdMeta);
    }
    if (data.containsKey('review_text')) {
      context.handle(
          _reviewTextMeta,
          reviewText.isAcceptableOrUnknown(
              data['review_text']!, _reviewTextMeta));
    }
    if (data.containsKey('emotion_tag')) {
      context.handle(
          _emotionTagMeta,
          emotionTag.isAcceptableOrUnknown(
              data['emotion_tag']!, _emotionTagMeta));
    }
    if (data.containsKey('discipline_score')) {
      context.handle(
          _disciplineScoreMeta,
          disciplineScore.isAcceptableOrUnknown(
              data['discipline_score']!, _disciplineScoreMeta));
    }
    if (data.containsKey('strategy_tags')) {
      context.handle(
          _strategyTagsMeta,
          strategyTags.isAcceptableOrUnknown(
              data['strategy_tags']!, _strategyTagsMeta));
    }
    if (data.containsKey('mistakes')) {
      context.handle(_mistakesMeta,
          mistakes.isAcceptableOrUnknown(data['mistakes']!, _mistakesMeta));
    }
    if (data.containsKey('improvements')) {
      context.handle(
          _improvementsMeta,
          improvements.isAcceptableOrUnknown(
              data['improvements']!, _improvementsMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TradeJournal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TradeJournal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tradeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trade_id'])!,
      reviewText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_text'])!,
      emotionTag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emotion_tag'])!,
      disciplineScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}discipline_score'])!,
      strategyTags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}strategy_tags'])!,
      mistakes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mistakes'])!,
      improvements: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}improvements'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TradeJournalsTable createAlias(String alias) {
    return $TradeJournalsTable(attachedDatabase, alias);
  }
}

class TradeJournal extends DataClass implements Insertable<TradeJournal> {
  final int id;

  /// 关联交易ID（唯一，一对一）
  final int tradeId;

  /// 复盘正文（Markdown格式）
  final String reviewText;

  /// 情绪标签：calm / impulsive / hesitant / fearful / greedy
  final String emotionTag;

  /// 执行纪律评分 1-5，5分=完全按计划执行
  final int disciplineScore;

  /// 策略标签，JSON数组字符串，如 '["顺势交易","突破开仓"]'
  final String strategyTags;

  /// 犯了什么错误（可为空）
  final String mistakes;

  /// 下次改进方向
  final String improvements;

  /// 更新时间
  final DateTime updatedAt;
  const TradeJournal(
      {required this.id,
      required this.tradeId,
      required this.reviewText,
      required this.emotionTag,
      required this.disciplineScore,
      required this.strategyTags,
      required this.mistakes,
      required this.improvements,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trade_id'] = Variable<int>(tradeId);
    map['review_text'] = Variable<String>(reviewText);
    map['emotion_tag'] = Variable<String>(emotionTag);
    map['discipline_score'] = Variable<int>(disciplineScore);
    map['strategy_tags'] = Variable<String>(strategyTags);
    map['mistakes'] = Variable<String>(mistakes);
    map['improvements'] = Variable<String>(improvements);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TradeJournalsCompanion toCompanion(bool nullToAbsent) {
    return TradeJournalsCompanion(
      id: Value(id),
      tradeId: Value(tradeId),
      reviewText: Value(reviewText),
      emotionTag: Value(emotionTag),
      disciplineScore: Value(disciplineScore),
      strategyTags: Value(strategyTags),
      mistakes: Value(mistakes),
      improvements: Value(improvements),
      updatedAt: Value(updatedAt),
    );
  }

  factory TradeJournal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TradeJournal(
      id: serializer.fromJson<int>(json['id']),
      tradeId: serializer.fromJson<int>(json['tradeId']),
      reviewText: serializer.fromJson<String>(json['reviewText']),
      emotionTag: serializer.fromJson<String>(json['emotionTag']),
      disciplineScore: serializer.fromJson<int>(json['disciplineScore']),
      strategyTags: serializer.fromJson<String>(json['strategyTags']),
      mistakes: serializer.fromJson<String>(json['mistakes']),
      improvements: serializer.fromJson<String>(json['improvements']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tradeId': serializer.toJson<int>(tradeId),
      'reviewText': serializer.toJson<String>(reviewText),
      'emotionTag': serializer.toJson<String>(emotionTag),
      'disciplineScore': serializer.toJson<int>(disciplineScore),
      'strategyTags': serializer.toJson<String>(strategyTags),
      'mistakes': serializer.toJson<String>(mistakes),
      'improvements': serializer.toJson<String>(improvements),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TradeJournal copyWith(
          {int? id,
          int? tradeId,
          String? reviewText,
          String? emotionTag,
          int? disciplineScore,
          String? strategyTags,
          String? mistakes,
          String? improvements,
          DateTime? updatedAt}) =>
      TradeJournal(
        id: id ?? this.id,
        tradeId: tradeId ?? this.tradeId,
        reviewText: reviewText ?? this.reviewText,
        emotionTag: emotionTag ?? this.emotionTag,
        disciplineScore: disciplineScore ?? this.disciplineScore,
        strategyTags: strategyTags ?? this.strategyTags,
        mistakes: mistakes ?? this.mistakes,
        improvements: improvements ?? this.improvements,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TradeJournal copyWithCompanion(TradeJournalsCompanion data) {
    return TradeJournal(
      id: data.id.present ? data.id.value : this.id,
      tradeId: data.tradeId.present ? data.tradeId.value : this.tradeId,
      reviewText:
          data.reviewText.present ? data.reviewText.value : this.reviewText,
      emotionTag:
          data.emotionTag.present ? data.emotionTag.value : this.emotionTag,
      disciplineScore: data.disciplineScore.present
          ? data.disciplineScore.value
          : this.disciplineScore,
      strategyTags: data.strategyTags.present
          ? data.strategyTags.value
          : this.strategyTags,
      mistakes: data.mistakes.present ? data.mistakes.value : this.mistakes,
      improvements: data.improvements.present
          ? data.improvements.value
          : this.improvements,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TradeJournal(')
          ..write('id: $id, ')
          ..write('tradeId: $tradeId, ')
          ..write('reviewText: $reviewText, ')
          ..write('emotionTag: $emotionTag, ')
          ..write('disciplineScore: $disciplineScore, ')
          ..write('strategyTags: $strategyTags, ')
          ..write('mistakes: $mistakes, ')
          ..write('improvements: $improvements, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tradeId, reviewText, emotionTag,
      disciplineScore, strategyTags, mistakes, improvements, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TradeJournal &&
          other.id == this.id &&
          other.tradeId == this.tradeId &&
          other.reviewText == this.reviewText &&
          other.emotionTag == this.emotionTag &&
          other.disciplineScore == this.disciplineScore &&
          other.strategyTags == this.strategyTags &&
          other.mistakes == this.mistakes &&
          other.improvements == this.improvements &&
          other.updatedAt == this.updatedAt);
}

class TradeJournalsCompanion extends UpdateCompanion<TradeJournal> {
  final Value<int> id;
  final Value<int> tradeId;
  final Value<String> reviewText;
  final Value<String> emotionTag;
  final Value<int> disciplineScore;
  final Value<String> strategyTags;
  final Value<String> mistakes;
  final Value<String> improvements;
  final Value<DateTime> updatedAt;
  const TradeJournalsCompanion({
    this.id = const Value.absent(),
    this.tradeId = const Value.absent(),
    this.reviewText = const Value.absent(),
    this.emotionTag = const Value.absent(),
    this.disciplineScore = const Value.absent(),
    this.strategyTags = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.improvements = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TradeJournalsCompanion.insert({
    this.id = const Value.absent(),
    required int tradeId,
    this.reviewText = const Value.absent(),
    this.emotionTag = const Value.absent(),
    this.disciplineScore = const Value.absent(),
    this.strategyTags = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.improvements = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : tradeId = Value(tradeId);
  static Insertable<TradeJournal> custom({
    Expression<int>? id,
    Expression<int>? tradeId,
    Expression<String>? reviewText,
    Expression<String>? emotionTag,
    Expression<int>? disciplineScore,
    Expression<String>? strategyTags,
    Expression<String>? mistakes,
    Expression<String>? improvements,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tradeId != null) 'trade_id': tradeId,
      if (reviewText != null) 'review_text': reviewText,
      if (emotionTag != null) 'emotion_tag': emotionTag,
      if (disciplineScore != null) 'discipline_score': disciplineScore,
      if (strategyTags != null) 'strategy_tags': strategyTags,
      if (mistakes != null) 'mistakes': mistakes,
      if (improvements != null) 'improvements': improvements,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TradeJournalsCompanion copyWith(
      {Value<int>? id,
      Value<int>? tradeId,
      Value<String>? reviewText,
      Value<String>? emotionTag,
      Value<int>? disciplineScore,
      Value<String>? strategyTags,
      Value<String>? mistakes,
      Value<String>? improvements,
      Value<DateTime>? updatedAt}) {
    return TradeJournalsCompanion(
      id: id ?? this.id,
      tradeId: tradeId ?? this.tradeId,
      reviewText: reviewText ?? this.reviewText,
      emotionTag: emotionTag ?? this.emotionTag,
      disciplineScore: disciplineScore ?? this.disciplineScore,
      strategyTags: strategyTags ?? this.strategyTags,
      mistakes: mistakes ?? this.mistakes,
      improvements: improvements ?? this.improvements,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tradeId.present) {
      map['trade_id'] = Variable<int>(tradeId.value);
    }
    if (reviewText.present) {
      map['review_text'] = Variable<String>(reviewText.value);
    }
    if (emotionTag.present) {
      map['emotion_tag'] = Variable<String>(emotionTag.value);
    }
    if (disciplineScore.present) {
      map['discipline_score'] = Variable<int>(disciplineScore.value);
    }
    if (strategyTags.present) {
      map['strategy_tags'] = Variable<String>(strategyTags.value);
    }
    if (mistakes.present) {
      map['mistakes'] = Variable<String>(mistakes.value);
    }
    if (improvements.present) {
      map['improvements'] = Variable<String>(improvements.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TradeJournalsCompanion(')
          ..write('id: $id, ')
          ..write('tradeId: $tradeId, ')
          ..write('reviewText: $reviewText, ')
          ..write('emotionTag: $emotionTag, ')
          ..write('disciplineScore: $disciplineScore, ')
          ..write('strategyTags: $strategyTags, ')
          ..write('mistakes: $mistakes, ')
          ..write('improvements: $improvements, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TradeRecordsTable tradeRecords = $TradeRecordsTable(this);
  late final $ChartSnapshotsTable chartSnapshots = $ChartSnapshotsTable(this);
  late final $CloseRecordsTable closeRecords = $CloseRecordsTable(this);
  late final $TradeJournalsTable tradeJournals = $TradeJournalsTable(this);
  late final TradesDao tradesDao = TradesDao(this as AppDatabase);
  late final SnapshotsDao snapshotsDao = SnapshotsDao(this as AppDatabase);
  late final CloseRecordsDao closeRecordsDao =
      CloseRecordsDao(this as AppDatabase);
  late final JournalsDao journalsDao = JournalsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tradeRecords, chartSnapshots, closeRecords, tradeJournals];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('trade_records',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('chart_snapshots', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('trade_records',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('close_records', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('trade_records',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('trade_journals', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$TradeRecordsTableCreateCompanionBuilder = TradeRecordsCompanion
    Function({
  Value<int> id,
  required String symbol,
  required String contract,
  required String exchange,
  required String direction,
  required double openPrice,
  required DateTime openTime,
  required int lots,
  Value<double?> stopLoss,
  Value<double?> takeProfit,
  Value<String> status,
  Value<int> signalScore,
  Value<String> notes,
  Value<String> entryReason,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$TradeRecordsTableUpdateCompanionBuilder = TradeRecordsCompanion
    Function({
  Value<int> id,
  Value<String> symbol,
  Value<String> contract,
  Value<String> exchange,
  Value<String> direction,
  Value<double> openPrice,
  Value<DateTime> openTime,
  Value<int> lots,
  Value<double?> stopLoss,
  Value<double?> takeProfit,
  Value<String> status,
  Value<int> signalScore,
  Value<String> notes,
  Value<String> entryReason,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$TradeRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $TradeRecordsTable, TradeRecord> {
  $$TradeRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChartSnapshotsTable, List<ChartSnapshot>>
      _chartSnapshotsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.chartSnapshots,
              aliasName: $_aliasNameGenerator(
                  db.tradeRecords.id, db.chartSnapshots.tradeId));

  $$ChartSnapshotsTableProcessedTableManager get chartSnapshotsRefs {
    final manager = $$ChartSnapshotsTableTableManager($_db, $_db.chartSnapshots)
        .filter((f) => f.tradeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_chartSnapshotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CloseRecordsTable, List<CloseRecord>>
      _closeRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.closeRecords,
              aliasName: $_aliasNameGenerator(
                  db.tradeRecords.id, db.closeRecords.tradeId));

  $$CloseRecordsTableProcessedTableManager get closeRecordsRefs {
    final manager = $$CloseRecordsTableTableManager($_db, $_db.closeRecords)
        .filter((f) => f.tradeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_closeRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TradeJournalsTable, List<TradeJournal>>
      _tradeJournalsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.tradeJournals,
              aliasName: $_aliasNameGenerator(
                  db.tradeRecords.id, db.tradeJournals.tradeId));

  $$TradeJournalsTableProcessedTableManager get tradeJournalsRefs {
    final manager = $$TradeJournalsTableTableManager($_db, $_db.tradeJournals)
        .filter((f) => f.tradeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tradeJournalsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TradeRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $TradeRecordsTable> {
  $$TradeRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symbol => $composableBuilder(
      column: $table.symbol, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contract => $composableBuilder(
      column: $table.contract, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exchange => $composableBuilder(
      column: $table.exchange, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get openPrice => $composableBuilder(
      column: $table.openPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openTime => $composableBuilder(
      column: $table.openTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lots => $composableBuilder(
      column: $table.lots, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get stopLoss => $composableBuilder(
      column: $table.stopLoss, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get takeProfit => $composableBuilder(
      column: $table.takeProfit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get signalScore => $composableBuilder(
      column: $table.signalScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entryReason => $composableBuilder(
      column: $table.entryReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> chartSnapshotsRefs(
      Expression<bool> Function($$ChartSnapshotsTableFilterComposer f) f) {
    final $$ChartSnapshotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chartSnapshots,
        getReferencedColumn: (t) => t.tradeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartSnapshotsTableFilterComposer(
              $db: $db,
              $table: $db.chartSnapshots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> closeRecordsRefs(
      Expression<bool> Function($$CloseRecordsTableFilterComposer f) f) {
    final $$CloseRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.closeRecords,
        getReferencedColumn: (t) => t.tradeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CloseRecordsTableFilterComposer(
              $db: $db,
              $table: $db.closeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> tradeJournalsRefs(
      Expression<bool> Function($$TradeJournalsTableFilterComposer f) f) {
    final $$TradeJournalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tradeJournals,
        getReferencedColumn: (t) => t.tradeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeJournalsTableFilterComposer(
              $db: $db,
              $table: $db.tradeJournals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TradeRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $TradeRecordsTable> {
  $$TradeRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symbol => $composableBuilder(
      column: $table.symbol, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contract => $composableBuilder(
      column: $table.contract, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exchange => $composableBuilder(
      column: $table.exchange, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get openPrice => $composableBuilder(
      column: $table.openPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openTime => $composableBuilder(
      column: $table.openTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lots => $composableBuilder(
      column: $table.lots, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get stopLoss => $composableBuilder(
      column: $table.stopLoss, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get takeProfit => $composableBuilder(
      column: $table.takeProfit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get signalScore => $composableBuilder(
      column: $table.signalScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entryReason => $composableBuilder(
      column: $table.entryReason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TradeRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TradeRecordsTable> {
  $$TradeRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get contract =>
      $composableBuilder(column: $table.contract, builder: (column) => column);

  GeneratedColumn<String> get exchange =>
      $composableBuilder(column: $table.exchange, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<double> get openPrice =>
      $composableBuilder(column: $table.openPrice, builder: (column) => column);

  GeneratedColumn<DateTime> get openTime =>
      $composableBuilder(column: $table.openTime, builder: (column) => column);

  GeneratedColumn<int> get lots =>
      $composableBuilder(column: $table.lots, builder: (column) => column);

  GeneratedColumn<double> get stopLoss =>
      $composableBuilder(column: $table.stopLoss, builder: (column) => column);

  GeneratedColumn<double> get takeProfit => $composableBuilder(
      column: $table.takeProfit, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get signalScore => $composableBuilder(
      column: $table.signalScore, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get entryReason => $composableBuilder(
      column: $table.entryReason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> chartSnapshotsRefs<T extends Object>(
      Expression<T> Function($$ChartSnapshotsTableAnnotationComposer a) f) {
    final $$ChartSnapshotsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chartSnapshots,
        getReferencedColumn: (t) => t.tradeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChartSnapshotsTableAnnotationComposer(
              $db: $db,
              $table: $db.chartSnapshots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> closeRecordsRefs<T extends Object>(
      Expression<T> Function($$CloseRecordsTableAnnotationComposer a) f) {
    final $$CloseRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.closeRecords,
        getReferencedColumn: (t) => t.tradeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CloseRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.closeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> tradeJournalsRefs<T extends Object>(
      Expression<T> Function($$TradeJournalsTableAnnotationComposer a) f) {
    final $$TradeJournalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tradeJournals,
        getReferencedColumn: (t) => t.tradeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeJournalsTableAnnotationComposer(
              $db: $db,
              $table: $db.tradeJournals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TradeRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TradeRecordsTable,
    TradeRecord,
    $$TradeRecordsTableFilterComposer,
    $$TradeRecordsTableOrderingComposer,
    $$TradeRecordsTableAnnotationComposer,
    $$TradeRecordsTableCreateCompanionBuilder,
    $$TradeRecordsTableUpdateCompanionBuilder,
    (TradeRecord, $$TradeRecordsTableReferences),
    TradeRecord,
    PrefetchHooks Function(
        {bool chartSnapshotsRefs,
        bool closeRecordsRefs,
        bool tradeJournalsRefs})> {
  $$TradeRecordsTableTableManager(_$AppDatabase db, $TradeRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TradeRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TradeRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TradeRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> symbol = const Value.absent(),
            Value<String> contract = const Value.absent(),
            Value<String> exchange = const Value.absent(),
            Value<String> direction = const Value.absent(),
            Value<double> openPrice = const Value.absent(),
            Value<DateTime> openTime = const Value.absent(),
            Value<int> lots = const Value.absent(),
            Value<double?> stopLoss = const Value.absent(),
            Value<double?> takeProfit = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> signalScore = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> entryReason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TradeRecordsCompanion(
            id: id,
            symbol: symbol,
            contract: contract,
            exchange: exchange,
            direction: direction,
            openPrice: openPrice,
            openTime: openTime,
            lots: lots,
            stopLoss: stopLoss,
            takeProfit: takeProfit,
            status: status,
            signalScore: signalScore,
            notes: notes,
            entryReason: entryReason,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String symbol,
            required String contract,
            required String exchange,
            required String direction,
            required double openPrice,
            required DateTime openTime,
            required int lots,
            Value<double?> stopLoss = const Value.absent(),
            Value<double?> takeProfit = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> signalScore = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> entryReason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TradeRecordsCompanion.insert(
            id: id,
            symbol: symbol,
            contract: contract,
            exchange: exchange,
            direction: direction,
            openPrice: openPrice,
            openTime: openTime,
            lots: lots,
            stopLoss: stopLoss,
            takeProfit: takeProfit,
            status: status,
            signalScore: signalScore,
            notes: notes,
            entryReason: entryReason,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TradeRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {chartSnapshotsRefs = false,
              closeRecordsRefs = false,
              tradeJournalsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chartSnapshotsRefs) db.chartSnapshots,
                if (closeRecordsRefs) db.closeRecords,
                if (tradeJournalsRefs) db.tradeJournals
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chartSnapshotsRefs)
                    await $_getPrefetchedData<TradeRecord, $TradeRecordsTable,
                            ChartSnapshot>(
                        currentTable: table,
                        referencedTable: $$TradeRecordsTableReferences
                            ._chartSnapshotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TradeRecordsTableReferences(db, table, p0)
                                .chartSnapshotsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tradeId == item.id),
                        typedResults: items),
                  if (closeRecordsRefs)
                    await $_getPrefetchedData<TradeRecord, $TradeRecordsTable,
                            CloseRecord>(
                        currentTable: table,
                        referencedTable: $$TradeRecordsTableReferences
                            ._closeRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TradeRecordsTableReferences(db, table, p0)
                                .closeRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tradeId == item.id),
                        typedResults: items),
                  if (tradeJournalsRefs)
                    await $_getPrefetchedData<TradeRecord, $TradeRecordsTable,
                            TradeJournal>(
                        currentTable: table,
                        referencedTable: $$TradeRecordsTableReferences
                            ._tradeJournalsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TradeRecordsTableReferences(db, table, p0)
                                .tradeJournalsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tradeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TradeRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TradeRecordsTable,
    TradeRecord,
    $$TradeRecordsTableFilterComposer,
    $$TradeRecordsTableOrderingComposer,
    $$TradeRecordsTableAnnotationComposer,
    $$TradeRecordsTableCreateCompanionBuilder,
    $$TradeRecordsTableUpdateCompanionBuilder,
    (TradeRecord, $$TradeRecordsTableReferences),
    TradeRecord,
    PrefetchHooks Function(
        {bool chartSnapshotsRefs,
        bool closeRecordsRefs,
        bool tradeJournalsRefs})>;
typedef $$ChartSnapshotsTableCreateCompanionBuilder = ChartSnapshotsCompanion
    Function({
  Value<int> id,
  required int tradeId,
  required int filterLevel,
  Value<String> timeframe,
  required String imagePath,
  Value<DateTime> capturedAt,
  Value<String> annotation,
  Value<int> fileSize,
});
typedef $$ChartSnapshotsTableUpdateCompanionBuilder = ChartSnapshotsCompanion
    Function({
  Value<int> id,
  Value<int> tradeId,
  Value<int> filterLevel,
  Value<String> timeframe,
  Value<String> imagePath,
  Value<DateTime> capturedAt,
  Value<String> annotation,
  Value<int> fileSize,
});

final class $$ChartSnapshotsTableReferences
    extends BaseReferences<_$AppDatabase, $ChartSnapshotsTable, ChartSnapshot> {
  $$ChartSnapshotsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TradeRecordsTable _tradeIdTable(_$AppDatabase db) =>
      db.tradeRecords.createAlias(
          $_aliasNameGenerator(db.chartSnapshots.tradeId, db.tradeRecords.id));

  $$TradeRecordsTableProcessedTableManager get tradeId {
    final $_column = $_itemColumn<int>('trade_id')!;

    final manager = $$TradeRecordsTableTableManager($_db, $_db.tradeRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tradeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ChartSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $ChartSnapshotsTable> {
  $$ChartSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get filterLevel => $composableBuilder(
      column: $table.filterLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeframe => $composableBuilder(
      column: $table.timeframe, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fileSize => $composableBuilder(
      column: $table.fileSize, builder: (column) => ColumnFilters(column));

  $$TradeRecordsTableFilterComposer get tradeId {
    final $$TradeRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableFilterComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChartSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChartSnapshotsTable> {
  $$ChartSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get filterLevel => $composableBuilder(
      column: $table.filterLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeframe => $composableBuilder(
      column: $table.timeframe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fileSize => $composableBuilder(
      column: $table.fileSize, builder: (column) => ColumnOrderings(column));

  $$TradeRecordsTableOrderingComposer get tradeId {
    final $$TradeRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChartSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChartSnapshotsTable> {
  $$ChartSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get filterLevel => $composableBuilder(
      column: $table.filterLevel, builder: (column) => column);

  GeneratedColumn<String> get timeframe =>
      $composableBuilder(column: $table.timeframe, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
      column: $table.capturedAt, builder: (column) => column);

  GeneratedColumn<String> get annotation => $composableBuilder(
      column: $table.annotation, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  $$TradeRecordsTableAnnotationComposer get tradeId {
    final $$TradeRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChartSnapshotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChartSnapshotsTable,
    ChartSnapshot,
    $$ChartSnapshotsTableFilterComposer,
    $$ChartSnapshotsTableOrderingComposer,
    $$ChartSnapshotsTableAnnotationComposer,
    $$ChartSnapshotsTableCreateCompanionBuilder,
    $$ChartSnapshotsTableUpdateCompanionBuilder,
    (ChartSnapshot, $$ChartSnapshotsTableReferences),
    ChartSnapshot,
    PrefetchHooks Function({bool tradeId})> {
  $$ChartSnapshotsTableTableManager(
      _$AppDatabase db, $ChartSnapshotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChartSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChartSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChartSnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> tradeId = const Value.absent(),
            Value<int> filterLevel = const Value.absent(),
            Value<String> timeframe = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<DateTime> capturedAt = const Value.absent(),
            Value<String> annotation = const Value.absent(),
            Value<int> fileSize = const Value.absent(),
          }) =>
              ChartSnapshotsCompanion(
            id: id,
            tradeId: tradeId,
            filterLevel: filterLevel,
            timeframe: timeframe,
            imagePath: imagePath,
            capturedAt: capturedAt,
            annotation: annotation,
            fileSize: fileSize,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int tradeId,
            required int filterLevel,
            Value<String> timeframe = const Value.absent(),
            required String imagePath,
            Value<DateTime> capturedAt = const Value.absent(),
            Value<String> annotation = const Value.absent(),
            Value<int> fileSize = const Value.absent(),
          }) =>
              ChartSnapshotsCompanion.insert(
            id: id,
            tradeId: tradeId,
            filterLevel: filterLevel,
            timeframe: timeframe,
            imagePath: imagePath,
            capturedAt: capturedAt,
            annotation: annotation,
            fileSize: fileSize,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ChartSnapshotsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tradeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (tradeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tradeId,
                    referencedTable:
                        $$ChartSnapshotsTableReferences._tradeIdTable(db),
                    referencedColumn:
                        $$ChartSnapshotsTableReferences._tradeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ChartSnapshotsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChartSnapshotsTable,
    ChartSnapshot,
    $$ChartSnapshotsTableFilterComposer,
    $$ChartSnapshotsTableOrderingComposer,
    $$ChartSnapshotsTableAnnotationComposer,
    $$ChartSnapshotsTableCreateCompanionBuilder,
    $$ChartSnapshotsTableUpdateCompanionBuilder,
    (ChartSnapshot, $$ChartSnapshotsTableReferences),
    ChartSnapshot,
    PrefetchHooks Function({bool tradeId})>;
typedef $$CloseRecordsTableCreateCompanionBuilder = CloseRecordsCompanion
    Function({
  Value<int> id,
  required int tradeId,
  required double closePrice,
  required DateTime closeTime,
  required int closeLots,
  required double pnl,
  Value<double> commission,
  Value<double> slipPoints,
  Value<String> closeReason,
  Value<String> notes,
  Value<DateTime> createdAt,
});
typedef $$CloseRecordsTableUpdateCompanionBuilder = CloseRecordsCompanion
    Function({
  Value<int> id,
  Value<int> tradeId,
  Value<double> closePrice,
  Value<DateTime> closeTime,
  Value<int> closeLots,
  Value<double> pnl,
  Value<double> commission,
  Value<double> slipPoints,
  Value<String> closeReason,
  Value<String> notes,
  Value<DateTime> createdAt,
});

final class $$CloseRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $CloseRecordsTable, CloseRecord> {
  $$CloseRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TradeRecordsTable _tradeIdTable(_$AppDatabase db) =>
      db.tradeRecords.createAlias(
          $_aliasNameGenerator(db.closeRecords.tradeId, db.tradeRecords.id));

  $$TradeRecordsTableProcessedTableManager get tradeId {
    final $_column = $_itemColumn<int>('trade_id')!;

    final manager = $$TradeRecordsTableTableManager($_db, $_db.tradeRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tradeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CloseRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CloseRecordsTable> {
  $$CloseRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get closePrice => $composableBuilder(
      column: $table.closePrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closeTime => $composableBuilder(
      column: $table.closeTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get closeLots => $composableBuilder(
      column: $table.closeLots, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get pnl => $composableBuilder(
      column: $table.pnl, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get commission => $composableBuilder(
      column: $table.commission, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get slipPoints => $composableBuilder(
      column: $table.slipPoints, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get closeReason => $composableBuilder(
      column: $table.closeReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$TradeRecordsTableFilterComposer get tradeId {
    final $$TradeRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableFilterComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CloseRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CloseRecordsTable> {
  $$CloseRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get closePrice => $composableBuilder(
      column: $table.closePrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closeTime => $composableBuilder(
      column: $table.closeTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get closeLots => $composableBuilder(
      column: $table.closeLots, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get pnl => $composableBuilder(
      column: $table.pnl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get commission => $composableBuilder(
      column: $table.commission, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get slipPoints => $composableBuilder(
      column: $table.slipPoints, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get closeReason => $composableBuilder(
      column: $table.closeReason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$TradeRecordsTableOrderingComposer get tradeId {
    final $$TradeRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CloseRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CloseRecordsTable> {
  $$CloseRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get closePrice => $composableBuilder(
      column: $table.closePrice, builder: (column) => column);

  GeneratedColumn<DateTime> get closeTime =>
      $composableBuilder(column: $table.closeTime, builder: (column) => column);

  GeneratedColumn<int> get closeLots =>
      $composableBuilder(column: $table.closeLots, builder: (column) => column);

  GeneratedColumn<double> get pnl =>
      $composableBuilder(column: $table.pnl, builder: (column) => column);

  GeneratedColumn<double> get commission => $composableBuilder(
      column: $table.commission, builder: (column) => column);

  GeneratedColumn<double> get slipPoints => $composableBuilder(
      column: $table.slipPoints, builder: (column) => column);

  GeneratedColumn<String> get closeReason => $composableBuilder(
      column: $table.closeReason, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TradeRecordsTableAnnotationComposer get tradeId {
    final $$TradeRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CloseRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CloseRecordsTable,
    CloseRecord,
    $$CloseRecordsTableFilterComposer,
    $$CloseRecordsTableOrderingComposer,
    $$CloseRecordsTableAnnotationComposer,
    $$CloseRecordsTableCreateCompanionBuilder,
    $$CloseRecordsTableUpdateCompanionBuilder,
    (CloseRecord, $$CloseRecordsTableReferences),
    CloseRecord,
    PrefetchHooks Function({bool tradeId})> {
  $$CloseRecordsTableTableManager(_$AppDatabase db, $CloseRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CloseRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CloseRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CloseRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> tradeId = const Value.absent(),
            Value<double> closePrice = const Value.absent(),
            Value<DateTime> closeTime = const Value.absent(),
            Value<int> closeLots = const Value.absent(),
            Value<double> pnl = const Value.absent(),
            Value<double> commission = const Value.absent(),
            Value<double> slipPoints = const Value.absent(),
            Value<String> closeReason = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CloseRecordsCompanion(
            id: id,
            tradeId: tradeId,
            closePrice: closePrice,
            closeTime: closeTime,
            closeLots: closeLots,
            pnl: pnl,
            commission: commission,
            slipPoints: slipPoints,
            closeReason: closeReason,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int tradeId,
            required double closePrice,
            required DateTime closeTime,
            required int closeLots,
            required double pnl,
            Value<double> commission = const Value.absent(),
            Value<double> slipPoints = const Value.absent(),
            Value<String> closeReason = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CloseRecordsCompanion.insert(
            id: id,
            tradeId: tradeId,
            closePrice: closePrice,
            closeTime: closeTime,
            closeLots: closeLots,
            pnl: pnl,
            commission: commission,
            slipPoints: slipPoints,
            closeReason: closeReason,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CloseRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tradeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (tradeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tradeId,
                    referencedTable:
                        $$CloseRecordsTableReferences._tradeIdTable(db),
                    referencedColumn:
                        $$CloseRecordsTableReferences._tradeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CloseRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CloseRecordsTable,
    CloseRecord,
    $$CloseRecordsTableFilterComposer,
    $$CloseRecordsTableOrderingComposer,
    $$CloseRecordsTableAnnotationComposer,
    $$CloseRecordsTableCreateCompanionBuilder,
    $$CloseRecordsTableUpdateCompanionBuilder,
    (CloseRecord, $$CloseRecordsTableReferences),
    CloseRecord,
    PrefetchHooks Function({bool tradeId})>;
typedef $$TradeJournalsTableCreateCompanionBuilder = TradeJournalsCompanion
    Function({
  Value<int> id,
  required int tradeId,
  Value<String> reviewText,
  Value<String> emotionTag,
  Value<int> disciplineScore,
  Value<String> strategyTags,
  Value<String> mistakes,
  Value<String> improvements,
  Value<DateTime> updatedAt,
});
typedef $$TradeJournalsTableUpdateCompanionBuilder = TradeJournalsCompanion
    Function({
  Value<int> id,
  Value<int> tradeId,
  Value<String> reviewText,
  Value<String> emotionTag,
  Value<int> disciplineScore,
  Value<String> strategyTags,
  Value<String> mistakes,
  Value<String> improvements,
  Value<DateTime> updatedAt,
});

final class $$TradeJournalsTableReferences
    extends BaseReferences<_$AppDatabase, $TradeJournalsTable, TradeJournal> {
  $$TradeJournalsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TradeRecordsTable _tradeIdTable(_$AppDatabase db) =>
      db.tradeRecords.createAlias(
          $_aliasNameGenerator(db.tradeJournals.tradeId, db.tradeRecords.id));

  $$TradeRecordsTableProcessedTableManager get tradeId {
    final $_column = $_itemColumn<int>('trade_id')!;

    final manager = $$TradeRecordsTableTableManager($_db, $_db.tradeRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tradeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TradeJournalsTableFilterComposer
    extends Composer<_$AppDatabase, $TradeJournalsTable> {
  $$TradeJournalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewText => $composableBuilder(
      column: $table.reviewText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emotionTag => $composableBuilder(
      column: $table.emotionTag, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get disciplineScore => $composableBuilder(
      column: $table.disciplineScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get strategyTags => $composableBuilder(
      column: $table.strategyTags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mistakes => $composableBuilder(
      column: $table.mistakes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get improvements => $composableBuilder(
      column: $table.improvements, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$TradeRecordsTableFilterComposer get tradeId {
    final $$TradeRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableFilterComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TradeJournalsTableOrderingComposer
    extends Composer<_$AppDatabase, $TradeJournalsTable> {
  $$TradeJournalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewText => $composableBuilder(
      column: $table.reviewText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emotionTag => $composableBuilder(
      column: $table.emotionTag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get disciplineScore => $composableBuilder(
      column: $table.disciplineScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get strategyTags => $composableBuilder(
      column: $table.strategyTags,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mistakes => $composableBuilder(
      column: $table.mistakes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get improvements => $composableBuilder(
      column: $table.improvements,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$TradeRecordsTableOrderingComposer get tradeId {
    final $$TradeRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TradeJournalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TradeJournalsTable> {
  $$TradeJournalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reviewText => $composableBuilder(
      column: $table.reviewText, builder: (column) => column);

  GeneratedColumn<String> get emotionTag => $composableBuilder(
      column: $table.emotionTag, builder: (column) => column);

  GeneratedColumn<int> get disciplineScore => $composableBuilder(
      column: $table.disciplineScore, builder: (column) => column);

  GeneratedColumn<String> get strategyTags => $composableBuilder(
      column: $table.strategyTags, builder: (column) => column);

  GeneratedColumn<String> get mistakes =>
      $composableBuilder(column: $table.mistakes, builder: (column) => column);

  GeneratedColumn<String> get improvements => $composableBuilder(
      column: $table.improvements, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TradeRecordsTableAnnotationComposer get tradeId {
    final $$TradeRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tradeId,
        referencedTable: $db.tradeRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradeRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.tradeRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TradeJournalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TradeJournalsTable,
    TradeJournal,
    $$TradeJournalsTableFilterComposer,
    $$TradeJournalsTableOrderingComposer,
    $$TradeJournalsTableAnnotationComposer,
    $$TradeJournalsTableCreateCompanionBuilder,
    $$TradeJournalsTableUpdateCompanionBuilder,
    (TradeJournal, $$TradeJournalsTableReferences),
    TradeJournal,
    PrefetchHooks Function({bool tradeId})> {
  $$TradeJournalsTableTableManager(_$AppDatabase db, $TradeJournalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TradeJournalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TradeJournalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TradeJournalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> tradeId = const Value.absent(),
            Value<String> reviewText = const Value.absent(),
            Value<String> emotionTag = const Value.absent(),
            Value<int> disciplineScore = const Value.absent(),
            Value<String> strategyTags = const Value.absent(),
            Value<String> mistakes = const Value.absent(),
            Value<String> improvements = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TradeJournalsCompanion(
            id: id,
            tradeId: tradeId,
            reviewText: reviewText,
            emotionTag: emotionTag,
            disciplineScore: disciplineScore,
            strategyTags: strategyTags,
            mistakes: mistakes,
            improvements: improvements,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int tradeId,
            Value<String> reviewText = const Value.absent(),
            Value<String> emotionTag = const Value.absent(),
            Value<int> disciplineScore = const Value.absent(),
            Value<String> strategyTags = const Value.absent(),
            Value<String> mistakes = const Value.absent(),
            Value<String> improvements = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TradeJournalsCompanion.insert(
            id: id,
            tradeId: tradeId,
            reviewText: reviewText,
            emotionTag: emotionTag,
            disciplineScore: disciplineScore,
            strategyTags: strategyTags,
            mistakes: mistakes,
            improvements: improvements,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TradeJournalsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tradeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (tradeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tradeId,
                    referencedTable:
                        $$TradeJournalsTableReferences._tradeIdTable(db),
                    referencedColumn:
                        $$TradeJournalsTableReferences._tradeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TradeJournalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TradeJournalsTable,
    TradeJournal,
    $$TradeJournalsTableFilterComposer,
    $$TradeJournalsTableOrderingComposer,
    $$TradeJournalsTableAnnotationComposer,
    $$TradeJournalsTableCreateCompanionBuilder,
    $$TradeJournalsTableUpdateCompanionBuilder,
    (TradeJournal, $$TradeJournalsTableReferences),
    TradeJournal,
    PrefetchHooks Function({bool tradeId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TradeRecordsTableTableManager get tradeRecords =>
      $$TradeRecordsTableTableManager(_db, _db.tradeRecords);
  $$ChartSnapshotsTableTableManager get chartSnapshots =>
      $$ChartSnapshotsTableTableManager(_db, _db.chartSnapshots);
  $$CloseRecordsTableTableManager get closeRecords =>
      $$CloseRecordsTableTableManager(_db, _db.closeRecords);
  $$TradeJournalsTableTableManager get tradeJournals =>
      $$TradeJournalsTableTableManager(_db, _db.tradeJournals);
}
