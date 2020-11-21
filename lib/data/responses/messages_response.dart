import 'package:flutter_base_app/data/model/message.dart';

class MessagesResponse {
  List<Message> _messages;

  MessagesResponse.fromJSON(response) {
    _messages = List<Message>.of(
      response['messages'].map<Message>(
        (message) => new Message.fromJSON(message)
      )
    );
  }

  List<Message> get messages => _messages;
}