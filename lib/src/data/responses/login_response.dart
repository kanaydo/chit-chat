import 'package:flutter_base_app/src/data/model/member.dart';

class LoginResponse {
  bool _result;
  String _message;
  Member _member;

  LoginResponse.fromJSON(json) {
    _result = json['result'];
    _message = json['message'];
    _member = new Member.fromJSON(json['member']);
  }

  bool get result => _result;
  String get message => _message;
  Member get member => _member;
}