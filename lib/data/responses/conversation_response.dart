/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/19/20, 10:56 PM
 */

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