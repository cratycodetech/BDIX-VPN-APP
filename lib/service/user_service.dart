import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<void> storeUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType);
  }

  Future<bool> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType');
    print("User Type: $userType");
    if(userType==null)
      {
        return true;
      }
    return false;
  }

  Future<void> removeUserType() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userType');
    print("User Type has been removed.");
  }
}
