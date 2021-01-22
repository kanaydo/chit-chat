/*
 * Created by Batara Kanaydo on 25/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/25/20, 9:49 AM
 */
import 'package:action_cable/action_cable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/model/message.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
part 'conversation_item_state.dart';

class ConversationItemCubit extends Cubit<ConversationItemState> {
  Conversation _conversation;
  User _friend;
  String _lastMessage = "";
  ActionCable _conversationCable, _friendCable;

  TextTheme _textTheme;

  ConversationItemCubit(Conversation conversation, User friend, TextTheme textTheme) : super(null) {
    this._conversation = conversation;
    this._friend = friend;
    this._textTheme = textTheme;
    //_init();
    _connectCable();
    _subscribeToFriendTypingChannel();
  }

  void _connectCable () {
    _conversationCable = _friendCable = ActionCable.Connect(
        DotEnv().env['CABLE'],
        onConnected: () { }
    );
    _subscribeToConversationChannel();
  }

  _subscribeToConversationChannel() {
    _conversationCable.subscribe(
        "MessageNotificationChannel",
        channelParams: {"conversation_id": _conversation.id},
        onSubscribed: () {},
        onDisconnected: () {},
        onMessage: (Map message) {
          Message newMessage = Message.fromJSON(message);
          _incomingMessage(newMessage);
        }
    );
  }
  _subscribeToFriendTypingChannel() {
    _friendCable.subscribe(
        "TypingNotificationsChannel",
        channelParams: {
          'conversation_id': _conversation.id,
          'user_id': _friend.id
        },
        onSubscribed: () {
          print('subscribed to ${_friend.id} typing channel');
        },
        onDisconnected: () {},
        onMessage: (Map message) {
          if(message['typing'] == true) {
            emit(ConversationItemIdle(widget: typing()));
          } else {
            if(_lastMessage != "") {
              emit(ConversationItemIdle(widget: lastMessage()));
            } else {
              emit(ConversationItemIdle(widget: Container()));
            }
          }
        }
    );
  }

  _incomingMessage(Message message) {
    this._lastMessage = message.content;
  }

  Widget lastMessage() {
    return Text(
      _lastMessage,
      style: _textTheme.caption.apply(
        color: Colors.grey
      ),
    );
  }

  Widget typing() {
    return Text(
      'typing..',
      style: _textTheme.caption.apply(
        fontStyle: FontStyle.italic,
        color: Colors.green
      ),
    );
  }

  void _init () {
    emit(ConversationItemIdle(widget: lastMessage()));
  }

}