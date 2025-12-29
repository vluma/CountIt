import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:countit/features/home/providers/space_provider.dart';
import 'package:countit/features/home/presentation/widgets/expiry_item_card.dart';
import 'package:countit/features/home/presentation/widgets/space_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spaces = ref.watch(spacesProvider);
    final theme = Theme.of(context);
    
    // Mock临期提醒数据
    final expiryItems = [
      {'name': '💊 泰诺', 'daysLeft': 2},
      {'name': '🍞 面包', 'hoursLeft': 12},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('有数'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            tooltip: '通知',
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(12),
              backgroundColor: theme.colorScheme.surfaceVariant,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {
              context.push('/inventory');
            },
            tooltip: '搜索',
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(12),
              backgroundColor: theme.colorScheme.surfaceVariant,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              
              // 欢迎区域
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '欢迎回来！',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '今天想找什么储备？',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              
              // 临期提醒
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '临期提醒',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // 查看全部临期商品
                    },
                    child: Text(
                      '查看全部',
                      style: TextStyle(color: theme.colorScheme.primary),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: expiryItems.length,
                  itemBuilder: (context, index) {
                    final item = expiryItems[index];
                    return Padding(
                      padding: EdgeInsets.only(right: index == expiryItems.length - 1 ? 0 : 16),
                      child: ExpiryItemCard(
                        name: item['name'] as String,
                        daysLeft: item['daysLeft'] as int?,
                        hoursLeft: item['hoursLeft'] as int?,
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 32),
              
              // 存储区域
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '存储区域',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // 管理存储区域
                    },
                    child: Text(
                      '管理',
                      style: TextStyle(color: theme.colorScheme.primary),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              spaces.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '加载失败: $error',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ),
                data: (spacesData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: spacesData.length,
                    itemBuilder: (context, index) {
                      final space = spacesData[index];
                      return SpaceCard(
                        space: space,
                        onTap: () {
                          // 导航到空间详情页
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.push('/add-item');
            },
            tooltip: '新增储备',
            child: const Icon(Icons.add),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: () {
              context.push('/settings');
            },
            tooltip: '设置',
            child: const Icon(Icons.settings),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
