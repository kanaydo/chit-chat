import 'package:flutter_base_app/src/data/model/user.dart';

class SignUpResponse {
  bool _result;
  String _message;
  User _user;

  SignUpResponse.fromJSON(json){
    _result = json['result'];
    _message = json['message'];
    _user = new User.fromJSON(json['member']);
  }

  bool get result => _result;
  String get message => _message;
  User get user => _user;
}