# 期货交易记录 App — 架构文档

## 概述

三重滤网期货交易记录 App，基于 Flutter 构建，支持 Android / iOS。

- **应用 ID**：`com.hzpfly.futures_trader`
- **最低 SDK**：Android 21 / iOS 12
- **语言**：Dart 3.x + Flutter 3.x

---

## 架构分层

```
┌─────────────────────────────────────┐
│  UI 层 (Screens & Widgets)          │  ← ConsumerWidget / ConsumerStatefulWidget
│  lib/features/{module}/screens/     │
├─────────────────────────────────────┤
│  状态管理层 (Riverpod)               │  ← StreamProvider / StateProvider / FutureProvider
│  lib/core/providers/                │
├─────────────────────────────────────┤
│  数据访问层 (Drift DAO)              │  ← @DriftAccessor / .watch*() Stream
│  lib/core/database/daos/            │
├─────────────────────────────────────┤
│  ORM 层 (Drift)                     │  ← 表定义、迁移、SQL 生成
│  lib/core/database/                 │
├─────────────────────────────────────┤
│  持久化层 (SQLite + 文件系统)         │
│  trades.db + 本地图片目录             │
└─────────────────────────────────────┘
```

**数据流方向**：SQLite → Drift → DAO → Riverpod Provider → UI Widget  
**事件流方向**：用户操作 → Widget callback → ref.write() / Navigator → Provider 更新 → UI 重绘

---

## 目录结构

```
futures_trader/
├── lib/
│   ├── main.dart                    # 入口：ProviderScope + Material 3 主题
│   ├── app_router.dart              # GoRouter 路由表（6 条路由）
│   ├── core/
│   │   ├── database/
│   │   │   ├── app_database.dart    # Drift 数据库定义
│   │   │   ├── tables/              # 4 张表的 schema
│   │   │   │   ├── trades.dart
│   │   │   │   ├── close_records.dart
│   │   │   │   ├── snapshots.dart
│   │   │   │   └── journals.dart
│   │   │   └── daos/                # 4 个 DAO
│   │   │       ├── trades_dao.dart
│   │   │       ├── close_records_dao.dart
│   │   │       ├── snapshots_dao.dart
│   │   │       └── journals_dao.dart
│   │   ├── providers/
│   │   │   └── app_providers.dart   # 全局 Riverpod Provider + TradeStats 模型
│   │   └── utils/
│   │       └── image_manager.dart   # 图片选取、content:// URI 处理、本地保存
│   ├── features/
│   │   ├── trade_list/              # 交易列表页
│   │   │   └── screens/
│   │   │       └── trade_list_screen.dart  # 主列表（月份/日期/品种筛选 + 统计）
│   │   │   └── widgets/
│   │   │       ├── stats_header.dart       # 统计头部卡片
│   │   │       └── trade_list_item.dart    # 交易列表项
│   │   ├── trade_entry/             # 新建/编辑交易
│   │   │   └── screens/
│   │   │       └── trade_entry_screen.dart # 表单录入页
│   │   └── trade_detail/            # 交易详情
│   │       └── screens/
│   │           └── trade_detail_screen.dart # 详情 + 平仓 + 盈亏计算
│   └── shared/
│       └── constants/
│           └── app_constants.dart   # 25 个期货品种定义（含合约乘数）
├── android/
├── ios/
├── test/
├── pubspec.yaml
├── README.md
└── ARCHITECTURE.md                  # 本文件
```

---

## 路由设计

由 `GoRouter` 管理，共 6 条路由：

| 路径 | 页面 | 说明 |
|---|---|---|
| `/` | `TradeListScreen` | 首页：交易列表 + 统计 |
| `/trade/new` | `TradeEntryScreen` | 新建交易 |
| `/trade/:id` | `TradeDetailScreen` | 交易详情 + 平仓操作 |
| `/trade/:id/edit` | `TradeEntryScreen` | 编辑已有交易 |
| `/analytics` | 占位 | 盘后分析（待开发） |
| `/settings` | 占位 | 设置（待开发） |

所有路由参数通过 `extra` 或 path param 传递交易 ID，无需全局状态。

---

## 数据模型

### 核心表

**trades（交易主表）**

| 字段 | 类型 | 说明 |
|---|---|---|
| `id` | int (PK) | 自增 ID |
| `symbol` | text | 品种代码（如 RB、MA） |
| `direction` | text | long / short |
| `open_price` | real | 开仓价 |
| `initial_lots` | int | 初始手数 |
| `open_time` | datetime | 开仓时间 |
| `status` | text | open / closed |
| `initial_stop` | real | 初始止损 |
| `notes` | text | 备注 |
| `tags` | text | 标签（JSON 字符串） |

**close_records（平仓记录）**

| 字段 | 类型 | 说明 |
|---|---|---|
| `id` | int (PK) | 自增 ID |
| `trade_id` | int (FK) | 关联 trades.id |
| `close_price` | real | 平仓价 |
| `close_lots` | int | 平仓手数 |
| `close_time` | datetime | 平仓时间 |
| `reason` | text | 平仓理由 |
| `pnl` | real | 本次平仓盈亏 |

**snapshots（截图）** — 关联交易的多张截图路径  
**journals（复盘日志）** — Markdown 格式复盘记录

---

## 状态管理

全部使用 **Riverpod**，在 `app_providers.dart` 中集中声明。

### Provider 类型与用途

| Provider | 类型 | 用途 |
|---|---|---|
| `selectedMonthProvider` | `StateProvider<DateTime>` | 当前选中月份（默认本月） |
| `selectedDayProvider` | `StateProvider<DateTime?>` | 选中具体日期（null = 不按天过滤） |
| `tradeListByStatusProvider(status)` | `StreamProvider.family` | 按状态（all/open/closed）实时监听交易列表 |
| `allTradesProvider` | `StreamProvider` | 全部交易实时监听 |
| `monthStatsProvider(month)` | `FutureProvider.family` | 按月聚合盈亏/胜率 |
| `dayStatsProvider(day)` | `FutureProvider.family` | 按天聚合盈亏/胜率 |
| `tradeDetailProvider(id)` | `FutureProvider.family` | 单笔交易详情 |

### 级联刷新机制

```
Database change
  → Drift stream 触发
    → DAO.watch*() 发出新数据
      → StreamProvider 更新
        → ConsumerWidget 重建
```

无需手动 `setState()`、无需 `ChangeNotifier`，所有 UI 自动响应数据变更。

---

## 主题系统

- **框架**：Material 3（`useMaterial3: true`）
- **主色**：`seedColor = Color(0xFF1565C0)`（深蓝）
- **字体**：系统默认（Android Roboto / iOS SF）
- **全局样式**：在 `main.dart` 的 `ThemeData` 中统一定制
  - 卡片：圆角、阴影
  - 输入框：outlined 样式、统一圆角
  - 按钮：FilledButton 为主
  - Chip：品种筛选标签

### 关键颜色常量

| 常量 | 值 | 用途 |
|---|---|---|
| `kLongColor` | `#EF5350` 红 | 多头标识 |
| `kShortColor` | `#42A5F5` 蓝 | 空头标识 |
| `kProfitColor` | `#EF5350` 红 | 盈利显示 |
| `kLossColor` | `#4CAF50` 绿 | 亏损显示 |

---

## 合约乘数

`FuturesSymbol` 类包含 `multiplier` 字段，平仓盈亏公式：

```dart
pnl = (平仓价 - 开仓价) × multiplier × 平仓手数
```

全部 25 个品种已录入准确乘数，详见 `lib/shared/constants/app_constants.dart`。

---

## 图片管理

`lib/core/utils/image_manager.dart` 负责：

1. 弹出选择器（`ImageSource` 对话框），先选图再通过 `Navigator.pop(ctx, path)` 返回
2. 处理 Android 10+ `content://` URI → `XFile.readAsBytes()` + `File.writeAsBytes()`
3. 无外部压缩库依赖（已移除 `flutter_image_compress`）

---

## 构建

```bash
# Debug
flutter run

# Release APK
flutter build apk --release
# 输出：build/app/outputs/flutter-apk/app-release.apk
```

---

## 测试

```bash
# 静态分析
flutter analyze

# 模拟器测试
adb devices                    # 确认连接
flutter run                    # 安装到模拟器
```

---

## 版本历史

| 版本 | commit | 说明 |
|---|---|---|
| v1.0.0 | `633c48d` | MVP：交易录入、平仓、图片上传 |
| - | `358f4be` | 清理 ephemeral 文件、完善 gitignore |
| - | `5a6dbac` | 月份切换 + 按日期分组 |
| - | `b200cca` | 按具体日期筛选 + 日统计 |
| - | `a60645b` | 清理 lint warnings |

---

## 技术栈

| 层 | 技术 |
|---|---|
| 框架 | Flutter 3.x + Dart 3.x |
| 状态管理 | Riverpod 2.x |
| 路由 | GoRouter |
| 数据库 | Drift (SQLite ORM) |
| 图片选取 | image_picker |
| UI | Material 3 |
| 日期格式化 | intl |
