/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 9:27 PM
 */

part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatIdle extends ChatState {
  final List<Message> messages;
  final int userId;
  ChatIdle({ this.messages, this.userId });
}

class ChatLoading extends ChatState {
  final String message;
  ChatLoading({ this.message });
}

class ChatError extends ChatState {
  final String message;
  ChatError({ this.message });
}

class ChatFatalError extends ChatState {
  final String message;
  ChatFatalError({ this.message });
}