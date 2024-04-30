
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _singleton = Preferences._internal();

  factory Preferences() {
    return _singleton;
  }

  Preferences._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  void saveLastRead(int kitob, int bet) {
    _prefs?.setInt("kitob", kitob);
    _prefs?.setInt("bet", bet);
  }

  int getLastReadKitob() {
    return _prefs?.getInt("kitob") ?? 0;
  }
  int getLastReadBet() {
    return _prefs?.getInt("bet") ?? 0;
  }
}
