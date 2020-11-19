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