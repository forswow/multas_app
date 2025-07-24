import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  factory UserPref() => UserPref._internal();
  UserPref._internal();
  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async =>
      SharedPreferences.getInstance();


  static bool get isDark => _prefs.getBool('isDark') ?? false;
  static set isDark(bool isDark) => _prefs.setBool('isDark', isDark);
}
