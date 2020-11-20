import 'package:action_cable/action_cable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/repository/conversation_repository.dart';
import 'package:flutter_base_app/data/responses/conversation_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'conversations_state.dart';

class ConversationsCubit extends Cubit<ConversationsState> {
  var sessionManager = SessionManager();
  var conversationRepository = ConversationRepository();
  List<Conversation> conversations;
  int userId;

  ConversationsCubit() : super(null) {
    _init();
  }

  void _init() async {
    var userId = await sessionManager.getActiveMember();
    if (userId != 0 || userId != null) {
      this.userId = userId;
      fetchUserConversations();
      connectToUserNotificationChannel();
    }
  }

  void fetchUserConversations() async {
    emit(ConversationsLoading(message: 'getting your conversations'));
    var userId = await sessionManager.getActiveMember();
    if (userId != 0 || userId != null) {
      try {
        ConversationResponse conversationResponse = await conversationRepository.userConversations(userId);
        this.conversations = conversationResponse.conversations;
        emit(
            ConversationsIdle(
                conversations: conversations,
                userId: userId
            )
        );
      } on ApiException catch (apiException) {
        emit(
            ConversationsError(
                message: apiException.toString()
            )
        );
      } catch (exception) {
        emit(
            ConversationsFatalError(
                message: exception.toString()
            )
        );
      }
    }
  }

  void connectToUserNotificationChannel() {
    var cable = ActionCable.Connect(
        DotEnv().env['CABLE'], onConnected: () {
          print("connected");
        }
    );
    cable.subscribe(
        "UserNotificationChannel",
        channelParams: {"user_id": userId},
        onSubscribed: () {},
        onDisconnected: () {},
        onMessage: (Map message) {
          Conversation conversation = Conversation.fromJSON(message);
          _incomingConversation(conversation);
        }
    );
  }

  void _incomingConversation(Conversation conversation) {
    this.conversations.add(conversation);
    emit(
        ConversationsIdle(
            conversations: conversations,
            userId: userId
        )
    );
  }
}
