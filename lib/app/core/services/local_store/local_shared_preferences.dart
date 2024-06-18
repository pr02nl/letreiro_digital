import 'package:letreiro_digital/app/core/services/local_store/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreferences implements LocalStorage {
  @override
  Future<void> delete(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  @override
  Future<String> get(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  @override
  Future<void> put(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
