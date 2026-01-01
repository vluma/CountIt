import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:countit/routing/app_router.dart';
import 'package:countit/core/theme/app_theme.dart';
import 'package:countit/core/theme/theme_provider.dart';
import 'package:countit/services/user_service.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _router = AppRouter().router;
  bool _isCheckingLoginStatus = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final isLoggedIn = await UserService.isLoggedIn();
      setState(() {
        _isLoggedIn = isLoggedIn;
        _isCheckingLoginStatus = false;
      });
      
      // 如果已经登录，导航到首页
      if (isLoggedIn) {
        _router.go('/');
      }
    } catch (e) {
      setState(() {
        _isCheckingLoginStatus = false;
        _isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);

    if (_isCheckingLoginStatus) {
      // 显示加载指示器
      return MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        debugShowCheckedModeBanner: false,
      );
    }

    return MaterialApp.router(
      title: '有数 - CountIt',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
