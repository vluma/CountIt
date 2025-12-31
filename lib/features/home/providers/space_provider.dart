import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countit/features/home/domain/models/space.dart';
import 'package:countit/services/database_service.dart';

class SpacesNotifier extends AsyncNotifier<List<Space>> {
  @override
  Future<List<Space>> build() async {
    // 确保数据库初始化完成后再查询
    try {
      // 使用Future.delayed给数据库初始化一些时间
      await Future.delayed(const Duration(milliseconds: 100));
      return await DatabaseService().getSpaces();
    } catch (e) {
      print('获取空间列表失败: $e');
      return []; // 返回空列表而不是抛出错误，避免UI崩溃
    }
  }
}

final spacesProvider = AsyncNotifierProvider<SpacesNotifier, List<Space>>(() {
  return SpacesNotifier();
});
