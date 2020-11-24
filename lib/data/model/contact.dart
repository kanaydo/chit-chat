/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 5:26 PM
 */

import 'package:flutter_base_app/data/model/user.dart';

class Contact {
  int _id;
  User _friend;

  Contact.fromJSON(contact) {
    _id = contact['id'];
    _friend = new User.fromJSON(contact['friend']);
  }

  int get id => _id;
  User get friend => _friend;
}