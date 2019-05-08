import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _registered = "registered";

  static Future<String> getPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_registered) ?? "";
  }

   static Future<bool> setPin(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_registered, value);
  }
}
