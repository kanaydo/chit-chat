import 'user.dart';

class Conversation {
  int _id;
  User _userOne;
  User _userTwo;

  Conversation.fromJSON(conversation) {
    _id = conversation['id'];
    _userOne = new User.fromJSON(conversation['user_one']);
    _userTwo = new User.fromJSON(conversation['user_two']);
  }

  int get id => _id;
  User get userOne => _userOne;
  User get userTwo => _userTwo;
}