import 'package:shared_preferences/shared_preferences.dart';

class UserService{
  static setUserId(String userId) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('uid', userId);
  }
   static getUserId() async {
    var pref = await SharedPreferences.getInstance();
    pref.getString('uid');
  }
}