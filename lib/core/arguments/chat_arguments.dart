import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/model/user.dart';

class ChatArgument {
  final Conversation conversation;
  final User friend;
  ChatArgument({this.conversation, this.friend});
}