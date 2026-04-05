import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _singleton = SharedPrefs._internal();

  SharedPrefs._internal();

  factory SharedPrefs() {
    return _singleton;
  }

  Future<bool> isFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('is_first_time') ?? true;

    if (isFirstTime) {
      await prefs.setBool('is_first_time', false);
    }

    return isFirstTime;
  }

  Future<bool> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false;
  }

  Future<void> setTheme(bool isDarkMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
