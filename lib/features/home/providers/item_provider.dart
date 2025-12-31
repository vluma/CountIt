import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countit/features/home/domain/models/item.dart';
import 'package:countit/services/database_service.dart';

class ItemNotifier extends AsyncNotifier<List<Item>> {
  @override
  Future<List<Item>> build() async {
    // 确保数据库初始化完成后再查询
    try {
      // 使用Future.delayed给数据库初始化一些时间
      await Future.delayed(const Duration(milliseconds: 100));
      return await DatabaseService().getItems();
    } catch (e) {
      print('获取物品列表失败: $e');
      return []; // 返回空列表而不是抛出错误，避免UI崩溃
    }
  }

  Future<void> addItem(Item item) async {
    await DatabaseService().addItem(item);
    ref.invalidateSelf();
  }

  Future<void> updateItem(Item item) async {
    await DatabaseService().updateItem(item);
    ref.invalidateSelf();
  }

  Future<void> deleteItem(int id) async {
    await DatabaseService().deleteItem(id);
    ref.invalidateSelf();
  }
}

final itemProvider = AsyncNotifierProvider<ItemNotifier, List<Item>>(() {
  return ItemNotifier();
});
