
import 'package:flutter_base_app/data/model/user.dart';

class SignInResponse {
  User _user;

  SignInResponse.fromJSON(json) {
    _user = new User.fromJSON(json['user']);
  }

  User get user => _user;
}