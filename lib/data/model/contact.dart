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