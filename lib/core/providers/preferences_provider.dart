import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async =>
    SharedPreferences.getInstance();

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<bool> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return prefs.getBool('isDark') ?? false;
  }

  Future<void> toggleTheme() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final currentValue = state.valueOrNull ?? false;
    final newValue = !currentValue;
    await prefs.setBool('isDark', newValue);
    state = AsyncValue.data(newValue);
  }
}
