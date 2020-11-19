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