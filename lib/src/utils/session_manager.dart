import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  // set active member
  void setActiveMember(Member member) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // set active user id
    prefs.setInt(MEMBER_ID_KEY, member.id);
    // set active session to true
    prefs.setBool(MEMBER_LOGIN_STATUS_KEY, true);
  }

  Future<int> getActiveMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(MEMBER_ID_KEY) ?? 0;
  }

  Future<bool> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(MEMBER_LOGIN_STATUS_KEY) ?? false;
  }

  Future<bool> logoutMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(MEMBER_ID_KEY);
    prefs.remove(MEMBER_LOGIN_STATUS_KEY);
    bool result = false;
    if (prefs.containsKey(MEMBER_ID_KEY) && prefs.containsKey(MEMBER_LOGIN_STATUS_KEY)) {
      result = false;
    } else {
      return true;
    }
    return result;
  }

}