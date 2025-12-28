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
    
    // Mock临期提醒数据
    final expiryItems = [
      {'name': '💊 泰诺', 'daysLeft': 2},
      {'name': '🍞 面包', 'hoursLeft': 12},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text('我的空间导航'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.push('/inventory');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 欢迎和快速搜索
              Text(
                '欢迎回来，今天想找什么？',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: '快速搜索储备...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 临期提醒
              Text(
                '临期提醒',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: expiryItems.length,
                  itemBuilder: (context, index) {
                    final item = expiryItems[index];
                    return ExpiryItemCard(
                      name: item['name'] as String,
                      daysLeft: item['daysLeft'] as int?,
                      hoursLeft: item['hoursLeft'] as int?,
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 存储区域
              Text(
                '存储区域',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              spaces.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('加载失败: $error')),
                data: (spacesData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1.0,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 导航到添加物品页面
          context.push('/add-item');
        },
        tooltip: '添加物品',
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // 首页
              break;
            case 1:
              // 添加物品
              context.push('/add-item');
              break;
            case 2:
              // 我的
              context.push('/settings');
              break;
          }
        },
      ),
    );
  }
}
