import 'package:multas_app/core/providers/preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
