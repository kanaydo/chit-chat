import 'package:flutter_base_app/src/data/model/user.dart';

class ProfileResponse {
  User _user;
  ProfileResponse.fromJSON(json) {
    _user = new User.fromJSON(json['member']);
  }

  User get user => _user;
}