import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';

import 'package:countit/features/home/presentation/pages/home_page.dart';
import 'package:countit/features/inventory/presentation/pages/add_item_page.dart';
import 'package:countit/features/profile/presentation/pages/profile_page.dart';

class MainContainerPage extends StatefulWidget {
  const MainContainerPage({super.key});

  @override
  State<MainContainerPage> createState() => _MainContainerPageState();
}

class _MainContainerPageState extends State<MainContainerPage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // 主要内容区域
          IndexedStack(
            index: _selectedIndex,
            children: [
              HomePage(scrollController: _scrollController),
              const AddItemPage(),
              const ProfilePage(),
            ],
          ),
          // 底部导航栏（重叠在内容上方）
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DotCurvedBottomNav(
              scrollController: _scrollController,
              hideOnScroll: true,
              indicatorColor: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.ease,
              selectedIndex: _selectedIndex,
              indicatorSize: 5,
              borderRadius: 25,
              height: 70,
              onTap: _onItemTapped,
              items: [
                Icon(
                  Icons.home,
                  size: 24,
                  color: _selectedIndex == 0 ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                Icon(
                  Icons.add_box,
                  size: 24,
                  color: _selectedIndex == 1 ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                Icon(
                  Icons.person,
                  size: 24,
                  color: _selectedIndex == 2 ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
