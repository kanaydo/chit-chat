
/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 10:07 PM
 */

import 'package:flutter_base_app/data/model/user.dart';

class SignInResponse {
  User _user;

  SignInResponse.fromJSON(json) {
    _user = new User.fromJSON(json['user']);
  }

  User get user => _user;
}