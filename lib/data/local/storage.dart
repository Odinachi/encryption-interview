import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static final AppStorage instance = AppStorage._instance();

  AppStorage._instance();

  void savePinCode(String pincode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(dotenv.env['my-code-pin'] ?? "", pincode);
  }

  Future<String?> getPinCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dotenv.env['my-code-pin'] ?? "");
  }

  Future<String?> getRequestToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dotenv.env['JWT'] ?? "");
  }

  void saveRequestToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(dotenv.env['JWT'] ?? "", token);
  }
}
