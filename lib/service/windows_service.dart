import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class KeyStorage {
  static Future<String> getUserKey() async {
    final prefs = await SharedPreferences.getInstance();
    String? userKey = prefs.getString('user_key');

    if (userKey == null) {
      var uuid = Uuid();
      userKey = uuid.v4();
      await prefs.setString('user_key', userKey);
    }

    return userKey;
  }
}
