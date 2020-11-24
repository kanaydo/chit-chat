/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/20/20, 3:00 PM
 */

import 'package:flutter_base_app/data/model/user.dart';

class UserProfileResponse {
  User _user;

  UserProfileResponse.fromJSON(user) {
    _user = new User.fromJSON(user['user']);
  }

  User get user => _user;
}