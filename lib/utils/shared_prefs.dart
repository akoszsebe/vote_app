import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _registered = "registered";
    static final String _logedin = "logedin";

  static Future<String> getPin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_registered) ?? "";
  }

   static Future<bool> setPin(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_registered, value);
  }

  static Future<bool> getLogedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_logedin) ?? false;
  }

   static Future<bool> setLogedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_logedin, value);
  }
}
