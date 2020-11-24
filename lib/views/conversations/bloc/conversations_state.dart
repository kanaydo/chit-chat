/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/19/20, 11:10 PM
 */

part of 'conversations_cubit.dart';

@immutable
abstract class ConversationsState {}

class ConversationsIdle extends ConversationsState {
  final List<Conversation> conversations;
  final int userId;
  ConversationsIdle({ this.conversations, this.userId });
}

class ConversationsLoading extends ConversationsState {
  final String message;
  ConversationsLoading({ this.message });
}

class ConversationsError extends ConversationsState {
  final String message;
  ConversationsError({ this.message });
}

class ConversationsFatalError extends ConversationsState {
  final String message;
  ConversationsFatalError({ this.message });
}