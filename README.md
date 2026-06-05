# 📈 三重滤网期货交易记录

个人期货投资者专用的跨平台交易日志工具，基于**三重滤网交易系统**设计，帮助系统性记录每一笔交易并回顾决策过程。

## ✨ 功能特性

### 核心功能
- 📝 **三步录入**：选择品种 → 上传三重滤网 K 线截图 → 确认开仓信息
- 🔍 **K 线图管理**：日线 / 60 分钟 / 15 分钟三档截图，支持捏合缩放浏览
- 📊 **平仓记录**：完整记录平仓原因（止损/止盈/主动/反向/交割）
- 📋 **交易日志**：每笔交易可附策略说明、情绪标签、复盘心得
- 📊 **交易列表**：按状态筛选（持仓中 / 已平仓 / 全部），实时统计盈亏

### 三重滤网系统
| 滤网 | 周期 | 说明 |
|------|------|------|
| 第一重 | 周线 / 月线 | 判断大周期趋势方向 |
| 第二重 | 日线 | 确认中周期入场时机 |
| 第三重 | 60分钟 / 15分钟 | 精确入场点位 |

## 🛠 技术栈

| 层级 | 技术 |
|------|------|
| UI 框架 | Flutter 3.x |
| 状态管理 | Riverpod 2.x |
| 本地数据库 | Drift (SQLite) |
| 路由 | go_router |
| 图表 | fl_chart |
| 图片选择 | image_picker + photo_view |
| 导出分享 | pdf + share_plus |

## 🚀 快速开始

### 环境要求
- Flutter SDK ≥ 3.4.0
- Dart SDK ≥ 3.4.0
- Android SDK 34+（编译需 36）
- （可选）Android Studio / VS Code

### 安装依赖
```bash
flutter pub get
# 生成 Drift ORM 代码（表结构变更后需重跑）
dart run build_runner build --delete-conflicting-outputs
```

### 运行调试
```bash
# 连接真机或启动模拟器后
flutter run

# 指定设备
flutter run -d emulator-5554
```

### 构建发布包
```bash
# Android APK（约 30-40MB）
flutter build apk --release

# 输出路径
# build/app/outputs/flutter-apk/app-release.apk
```

## 📁 项目结构

```
lib/
├── main.dart                          # 入口，主题配置
├── app_router.dart                  # go_router 路由表
├── core/
│   ├── database/                   # Drift 本地数据库
│   │   ├── app_database.dart       # 数据库主类 + 表定义
│   │   └── daos/                 # DAO（数据访问对象）
│   ├── providers/                 # Riverpod 全局 Provider
│   └── utils/
│       └── image_manager.dart      # 图片选择/压缩/保存工具
├── features/
│   ├── trade_list/                # 交易列表页
│   │   ├── screens/
│   │   └── widgets/              # StatsHeader, TradeListItem
│   ├── trade_entry/              # 新建交易（三步录入）
│   └── trade_detail/             # 交易详情（截图/平仓/日志）
└── shared/
    └── constants/
        └── app_constants.dart    # 品种定义、枚举、常量
```

## 📊 支持的期货品种

| 代码 | 品种 | 交易所 | 合约乘数 |
|------|------|--------|----------|
| JD | 鸡蛋 | DCE | 10 元/点 |
| LH | 生猪 | DCE | 16 元/吨 |
| C | 玉米 | DCE | 10 元/吨 |
| M | 豆粕 | DCE | 10 元/吨 |
| CF | 棉花 | CZCE | 5 元/吨 |
| FG | 玻璃 | CZCE | 20 元/吨 |
| RB | 螺纹钢 | SHFE | 10 元/吨 |
| SC | 原油 | INE | 1000 元/桶 |
| AU | 黄金 | SHFE | 1000 元/克 |
| AG | 白银 | SHFE | 15 元/克 |
| IF | 沪深300 | CFFEX | 300 元/点 |
| ... | 共 24 个品种 | | |

> 盈亏计算公式：`(平仓价 - 开仓价) × 合约乘数 × 手数`（多头）；空头方向相反

## 🔒 权限说明

### Android（`android/app/src/main/AndroidManifest.xml`）
- `READ_MEDIA_IMAGES` — 从相册选择 K 线截图
- `CAMERA` — 拍照上传截图
- `POST_NOTIFICATIONS` — 交易提醒通知

### iOS（`ios/Runner/Info.plist`）
- `NSPhotoLibraryUsageDescription`
- `NSCameraUsageDescription`

## 📝 开发笔记

### Drift ORM 代码生成
修改 `lib/core/database/tables/` 下的表定义后，必须重新生成：
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 数据库迁移
表结构变更时，在 `app_database.dart` 的 `onUpgrade` 中添加迁移逻辑，并将 `schemaVersion` +1。

### 常见问题
- **`.g.dart` 文件报红**：先运行上述 build_runner 命令
- **Android 编译失败**：确认 `compileSdk = 36`，且已启用 `coreLibraryDesugaring`
- **图片无法上传（Android 10+）**：已修复，使用 `XFile.readAsBytes()` 兼容 `content://` URI

## 📄 许可证

MIT License — 自由使用、修改和分发。

## 🙏 致谢

基于 Flutter、Drift、Riverpod 等优秀开源项目构建。
