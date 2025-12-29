import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  late SharedPreferences _prefs;
  static const String _themeModeKey = 'theme_mode';

  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.system;
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final themeModeString = _prefs.getString(_themeModeKey);
    if (themeModeString != null) {
      state = ThemeMode.values.byName(themeModeString);
    }
  }

  Future<void> toggleTheme() async {
    state = switch (state) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.system => ThemeMode.light,
    };
    await _saveTheme(state);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    await _saveTheme(themeMode);
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    await _prefs.setString(_themeModeKey, themeMode.name);
  }
}

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
);
