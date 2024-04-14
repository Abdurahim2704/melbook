import 'package:shared_preferences/shared_preferences.dart';

class LocalDBService {
  static const _usernameKey = 'username';
  static const _passwordKey = 'password';
  static const _showIntroKey = 'showIntro';
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUsername(String username) async {
    await prefs.setString(_usernameKey, username);
  }

  static Future<String?> getUsername() async {
    return prefs.getString(_usernameKey);
  }

  static Future<void> setPassword(String password) async {
    await prefs.setString(_passwordKey, password);
  }

  static Future<String?> getPassword() async {
    return prefs.getString(_passwordKey);
  }

  static Future<void> setShowIntro(bool showIntro) async {
    await prefs.setBool(_showIntroKey, showIntro);
  }

  static Future<bool> getShowIntro() async {
    return prefs.getBool(_showIntroKey) ?? true;
  }

  static Future<bool> hasUser() async {
    return (prefs.getString(_passwordKey) != null) &&
        (prefs.getString(_usernameKey) != null);
  }

  static Future<bool> logOut() async {
    return (await prefs.remove(_passwordKey)) &&
        (await prefs.remove(_usernameKey));
  }
}
