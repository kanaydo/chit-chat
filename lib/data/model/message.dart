/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 8:58 PM
 */

class Message {
  int _id;
  int _conversationId;
  int _userId;
  String _content;

  Message.fromJSON(message) {
    _id = message['id'];
    _conversationId = message['conversation_id'];
    _userId = message['user_id'];
    _content = message['content'];
  }

  int get id => _id;
  int get conversationId => _conversationId;
  int get userId => _userId;
  String get content => _content;
}
