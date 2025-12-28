import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countit/features/home/providers/item_provider.dart';

class ItemListWidget extends ConsumerWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemProvider);

    return items.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('加载失败: $error')),
      data: (itemsList) {
        if (itemsList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text('暂无物品'),
                SizedBox(height: 8),
                Text('点击右下角的 + 按钮添加第一个物品'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: itemsList.length,
          itemBuilder: (context, index) {
            final item = itemsList[index];
            return ListTile(
              leading: const Icon(Icons.check_box_outline_blank),
              title: Text(item.name),
              subtitle: Text(item.location ?? '未分类'),
              trailing: Text(item.count.toString()),
              onTap: () {
                // Navigate to item detail
              },
            );
          },
        );
      },
    );
  }
}
