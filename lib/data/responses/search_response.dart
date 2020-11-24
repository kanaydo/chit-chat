/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 9:49 PM
 */

import 'package:flutter_base_app/data/model/user.dart';

class SearchResponse {
  User _user;
  SearchResponse.fromJSON(response) {
    _user = User.fromJSON(response['user']);
  }
  User get user => _user;
}