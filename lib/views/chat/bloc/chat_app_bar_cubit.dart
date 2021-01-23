/*
 * Created by Batara Kanaydo on 25/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/25/20, 9:49 AM
 */
import 'package:action_cable/action_cable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

part 'chat_app_bar_state.dart';

class ChatAppBarCubit extends Cubit<ChatAppBarState> {
  int _conversationId;
  int _friendId;
  ActionCable _friendCable;
  TextTheme _textTheme;

  ChatAppBarCubit(int conversationId, int friendId, TextTheme textTheme) : super(null) {
    this._conversationId = conversationId;
    this._friendId = friendId;
    this._textTheme = textTheme;
    _connectCable();
  }

  void _connectCable () {
    _friendCable = ActionCable.Connect(
        DotEnv().env['CABLE'],
        onConnected: () { }
    );
    _subscribeToFriendTypingChannel();
  }

  void _subscribeToFriendTypingChannel() {
    _friendCable.subscribe(
        "TypingNotificationsChannel",
        channelParams: {
          'conversation_id': _conversationId,
          'user_id': _friendId
        },
        onSubscribed: () {
          print('subscribed to $_friendId typing channel');
        },
        onDisconnected: () { },
        onMessage: (Map message) {
          if(message['typing'] == true) {
            emit(ChatAppBarIdle(widget: typing()));
          } else {
            emit(ChatAppBarIdle(widget: Container()));
          }
        }
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

}