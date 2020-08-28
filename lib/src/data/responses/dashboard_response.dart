import 'package:flutter_base_app/src/data/model/user.dart';

class DashboardResponse {
  User _user;
  DashboardResponse.fromJSON(json) {
    _user = new User.fromJSON(json['member']);
  }
  User get user => _user;
}