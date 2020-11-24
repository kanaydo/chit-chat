
/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

import 'package:flutter_base_app/data/model/user.dart';

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