import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSettingsNotifier extends Notifier<HomeSettings> {
  late SharedPreferences _prefs;
  static const String _showExpiryReminderKey = 'show_expiry_reminder';
  static const String _showStorageAreaKey = 'show_storage_area';

  @override
  HomeSettings build() {
    _loadSettings();
    return const HomeSettings(
      showExpiryReminder: true,
      showStorageArea: true,
    );
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    final showExpiryReminder = _prefs.getBool(_showExpiryReminderKey) ?? true;
    final showStorageArea = _prefs.getBool(_showStorageAreaKey) ?? true;
    
    state = HomeSettings(
      showExpiryReminder: showExpiryReminder,
      showStorageArea: showStorageArea,
    );
  }

  Future<void> toggleExpiryReminder() async {
    final newValue = !state.showExpiryReminder;
    state = state.copyWith(showExpiryReminder: newValue);
    await _prefs.setBool(_showExpiryReminderKey, newValue);
  }

  Future<void> toggleStorageArea() async {
    final newValue = !state.showStorageArea;
    state = state.copyWith(showStorageArea: newValue);
    await _prefs.setBool(_showStorageAreaKey, newValue);
  }
}

class HomeSettings {
  final bool showExpiryReminder;
  final bool showStorageArea;

  const HomeSettings({
    required this.showExpiryReminder,
    required this.showStorageArea,
  });

  HomeSettings copyWith({
    bool? showExpiryReminder,
    bool? showStorageArea,
  }) {
    return HomeSettings(
      showExpiryReminder: showExpiryReminder ?? this.showExpiryReminder,
      showStorageArea: showStorageArea ?? this.showStorageArea,
    );
  }
}

final homeSettingsProvider = NotifierProvider<HomeSettingsNotifier, HomeSettings>(
  () => HomeSettingsNotifier(),
);
