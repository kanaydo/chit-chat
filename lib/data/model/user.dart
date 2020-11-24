/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/19/20, 11:50 PM
 */

import 'package:flutter_dotenv/flutter_dotenv.dart';

class User {
  int _id;
  String _email;
  String _name;
  String _username;
  String _image;


  User.fromJSON(user) {
    _id = user['id'];
    _email = user['email'];
    _name = user['name'];
    _username = user['username'];
    _image = user['image'];
  }

  int get id => _id;
  String get email => _email;
  String get name => _name;
  String get username => _username;
  String get image => "${DotEnv().env['ROOT']}$_image";
}