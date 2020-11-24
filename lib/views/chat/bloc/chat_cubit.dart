/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 11:54 PM
 */

import 'package:action_cable/action_cable.dart';
import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/model/message.dart';
import 'package:flutter_base_app/data/repository/conversation_repository.dart';
import 'package:flutter_base_app/data/responses/add_message_response.dart';
import 'package:flutter_base_app/data/responses/messages_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  var _sessionManager = SessionManager();
  var _conversationRepository = ConversationRepository();
  int _conversationId;
  int _userId;
  List<Message> _messages = [];

  ChatCubit(int conversationId) : super(null) {
    _init();
    this._conversationId = conversationId;
  }

  void _init() async {
    int userId = await _sessionManager.getActiveMember();
    if (userId != null || userId != 0) {
      this._userId = userId;
    }
    getConversationMessages();
    connectToConversationChannel();
  }

  void getConversationMessages() async {
    emit(ChatLoading(message: 'getting messages..'));
    try {
      MessagesResponse messagesResponse = await _conversationRepository.conversationMessages(_conversationId);
      this._messages = messagesResponse.messages;
      emit(ChatIdle(messages: _messages, userId: _userId));
    } on ApiException catch (api) {
      emit(ChatError(message: api.toString()));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  void addMessage(String content) async {
    Map<String, dynamic> params = {
      'message': {
        'user_id': _userId,
        'content': content
      }
    };
    try {
      AddMessageResponse addMessageResponse = await _conversationRepository.addMessage(_conversationId, params);
      print(addMessageResponse.message.content);
    } on ApiException catch (api) {
      print(api.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  connectToConversationChannel() {
    var cable = ActionCable.Connect(
        DotEnv().env['CABLE'], onConnected: () {
          print("connected to chat channel");
        }
    );
    cable.subscribe(
        "MessageNotificationChannel",
        channelParams: {"conversation_id": _conversationId},
        onSubscribed: () {},
        onDisconnected: () {},
        onMessage: (Map message) {
          Message newMessage = Message.fromJSON(message);
          incomingMessage(newMessage);
        }
    );
  }

  incomingMessage(Message message) {
    _messages.insert(0, message);
    emit(ChatIdle(messages: _messages, userId: _userId));
  }
}
