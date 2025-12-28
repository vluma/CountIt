import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countit/features/home/domain/models/item.dart';
import 'package:countit/services/database_service.dart';

class ItemNotifier extends AsyncNotifier<List<Item>> {
  @override
  Future<List<Item>> build() async {
    return await DatabaseService().getItems();
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
