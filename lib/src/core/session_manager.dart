import 'package:flutter_base_app/src/core/const/keys.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  void setActiveMember(Member member) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(Keys.KEY_USER_ID, member.id);
    prefs.setBool(Keys.KEY_USER_LOGIN_STATUS, true);
  }

  Future<int> getActiveMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Keys.KEY_USER_ID) ?? 0;
  }

  Future<bool> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Keys.KEY_USER_LOGIN_STATUS) ?? false;
  }

  Future<bool> logoutMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Keys.KEY_USER_ID);
    prefs.remove(Keys.KEY_USER_LOGIN_STATUS);
    bool result = false;
    if (prefs.containsKey(Keys.KEY_USER_ID) && prefs.containsKey(Keys.KEY_USER_LOGIN_STATUS)) {
      result = false;
    } else {
      return true;
    }
    return result;
  }

}