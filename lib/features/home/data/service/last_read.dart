// import 'package:shared_preferences/shared_preferences.dart';
//
// class Preferences {
//   static final Preferences _singleton = Preferences._internal();
//
//   factory Preferences() {
//     return _singleton;
//   }
//
//   Preferences._internal();
//
//   SharedPreferences? _prefs;
//
//   Future<void> init() async {
//     _prefs ??= await SharedPreferences.getInstance();
//   }
//
//   Future<void> saveLastRead(int kitob, int bet) async {
//     await _prefs?.setInt("kitob", kitob);
//     await _prefs?.setInt("bet", bet);
//     print("should saved: $bet");
//     print("Saved:${getLastReadBet()}");
//   }
//
//   int getLastReadKitob() {
//     return _prefs?.getInt("kitob") ?? 0;
//   }
//
//   int getLastReadBet() {
//     return _prefs?.getInt("bet") ?? 0;
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final String _lastReadBookIndexKey = 'lastReadBookIndex';
  final String _lastReadPageNumberKey = 'lastReadPageNumber';

  Future<void> saveLastReadBook(int bookIndex, double pixel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastReadBookIndexKey, bookIndex);
    await prefs.setDouble(_lastReadPageNumberKey, pixel);
  }

  Future<double> getLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    // final bookIndex = prefs.getInt(_lastReadBookIndexKey) ?? -1;
    final pageNumber = prefs.getDouble(_lastReadPageNumberKey) ?? 0;

    return pageNumber;
  }
}
