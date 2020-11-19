import 'package:flutter_base_app/data/model/conversation.dart';

class ConversationResponse {
  List<Conversation> _conversations;

  ConversationResponse.fromJSON(conversations) {
    _conversations = List<Conversation>.of(
      conversations['conversations'].map<Conversation>(
              (conversation) => new Conversation.fromJSON(conversation)
      )
    );
  }

  List<Conversation> get conversations => _conversations;
}