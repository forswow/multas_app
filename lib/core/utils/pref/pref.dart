import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static late SharedPreferences _prefs;

  factory UserPref() => UserPref._internal();
  UserPref._internal();

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static set isDark(bool isDark) => _prefs.setBool('isDark', isDark);
  static bool get isdDark => _prefs.getBool('isDark') ?? false;
}
