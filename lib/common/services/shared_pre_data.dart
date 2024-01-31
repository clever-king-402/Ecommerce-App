import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static const String _isFirstTime = "isFirstTime";

  static Future<void> setAppOpenFlag() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(_isFirstTime, false);
  }

  static Future<bool> get isFirstTime async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final result = await pref.getBool(_isFirstTime);
    return result ?? true;
  }
}
