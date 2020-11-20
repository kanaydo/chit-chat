import 'package:flutter_base_app/data/model/user.dart';

class UserProfileResponse {
  User _user;

  UserProfileResponse.fromJSON(user) {
    _user = new User.fromJSON(user['user']);
  }

  User get user => _user;
}