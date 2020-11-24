/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 9:02 PM
 */

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