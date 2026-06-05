// 图片管理工具
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageManager {
  static final ImagePicker _picker = ImagePicker();

  /// 显示来源选择底部弹窗
  /// 返回本地文件路径，用户取消返回 null
  static Future<String?> showPickerDialog(BuildContext context) async {
    // 弹窗先返回一个字符串信号，关闭后再去调 picker，避免 Navigator 冲突
    final source = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('从相册选择'),
                onTap: () => Navigator.pop(ctx, 'gallery'),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('拍照'),
                onTap: () => Navigator.pop(ctx, 'camera'),
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('取消'),
                onTap: () => Navigator.pop(ctx),
              ),
            ],
          ),
        ),
      ),
    );

    // 用户取消
    if (source == null || source.isEmpty) return null;

    // 弹窗完全关闭后，再调用系统选择器
    final XFile? picked = await _picker.pickImage(
      source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 90,
    );
    if (picked == null) return null;

    // 直接从 XFile 读取字节流（兼容 content:// 和 file://，无需额外处理）
    return _saveToAppDir(picked);
  }

  /// 从 XFile 保存到 app 文档目录，返回本地路径
  static Future<String> _saveToAppDir(XFile xFile) async {
    final bytes = await xFile.readAsBytes();

    final docDir = await getApplicationDocumentsDirectory();
    final chartsDir =
        Directory(p.join(docDir.path, 'futures_trader', 'charts'));
    await chartsDir.create(recursive: true);

    final fileName =
        'chart_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final destPath = p.join(chartsDir.path, fileName);

    final file = File(destPath);
    await file.writeAsBytes(bytes);
    return destPath;
  }

  /// 保存到交易专属目录（_saveTrade 调用）
  static Future<String> saveForTrade({
    required String sourcePath,
    required int tradeId,
    required int filterLevel,
  }) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw Exception('源文件不存在: $sourcePath');
    }

    final docDir = await getApplicationDocumentsDirectory();
    final tradeDir = Directory(
        p.join(docDir.path, 'futures_trader', 'charts', tradeId.toString()));
    await tradeDir.create(recursive: true);

    final fileName =
        'filter${filterLevel}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final destPath = p.join(tradeDir.path, fileName);

    await sourceFile.copy(destPath);
    return destPath;
  }

  /// 删除图片文件
  static Future<void> deleteImage(String imagePath) async {
    final file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// 获取文件大小（字节）
  static Future<int> getFileSize(String imagePath) async {
    final file = File(imagePath);
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }
}
