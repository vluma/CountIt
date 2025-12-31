import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countit/app.dart';
import 'package:countit/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 在后台线程初始化数据库，不阻塞应用启动
  Future.microtask(() async {
    try {
      await DatabaseService().initialize();
      print('数据库初始化成功');
    } catch (e) {
      print('数据库初始化失败: $e');
    }
  });
  
  runApp(const ProviderScope(child: MyApp()));
}
