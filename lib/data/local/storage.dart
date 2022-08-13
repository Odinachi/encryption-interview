import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static final AppStorage instance = AppStorage._instance();
  late SharedPreferences _sharedPreferences;
  AppStorage._instance();

  final _p = "splash";

  Future initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void savePinCode(String pincode) async {
    await _sharedPreferences.setString(
        dotenv.env['my-code-pin'] ?? "", pincode);
  }

  String? getPinCode() {
    return _sharedPreferences.getString(dotenv.env['my-code-pin'] ?? "");
  }

  String? getRequestToken() {
    return _sharedPreferences.getString(dotenv.env['JWT'] ?? "");
  }

  void saveRequestToken(String token) async {
    await _sharedPreferences.setString(dotenv.env['JWT'] ?? "", token);
  }

  void saveSeenSplash(bool seen) async {
    await _sharedPreferences.setBool(_p, seen);
  }

  bool? getSeenSplash() {
    return _sharedPreferences.getBool(_p);
  }
}
