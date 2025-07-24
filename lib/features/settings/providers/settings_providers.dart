import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/preferences_provider.dart';

part 'settings_providers.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<Map<String, dynamic>> build() async {
    final isDark = await ref.watch(themeNotifierProvider.future);
    return {
      'isDark': isDark,
    };
  }

  Future<void> toggleDarkMode() async {
    await ref.read(themeNotifierProvider.notifier).toggleTheme();
    ref.invalidateSelf();
  }
}