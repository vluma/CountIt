import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countit/core/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('设置'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // 主题设置
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '主题设置',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    RadioListTile<ThemeMode>(
                      title: const Text('浅色模式'),
                      value: ThemeMode.light,
                      groupValue: themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          themeNotifier.setTheme(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('深色模式'),
                      value: ThemeMode.dark,
                      groupValue: themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          themeNotifier.setTheme(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('跟随系统'),
                      value: ThemeMode.system,
                      groupValue: themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          themeNotifier.setTheme(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
