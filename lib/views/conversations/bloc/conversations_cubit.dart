import 'package:flutter/foundation.dart';
import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/repository/conversation_repository.dart';
import 'package:flutter_base_app/data/responses/conversation_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversations_state.dart';

class ConversationsCubit extends Cubit<ConversationsState> {

  var sessionManager = SessionManager();
  var conversationRepository = ConversationRepository();

  ConversationsCubit(): super(null) {
    fetchUserConversations();
  }

  void fetchUserConversations() async {
    emit(ConversationsLoading(message: 'getting your conversations'));
    var userId = await sessionManager.getActiveMember();
    if (userId != 0 || userId != null) {
      try {
        ConversationResponse conversationResponse = await conversationRepository.userConversations(userId);
        emit(
            ConversationsIdle(
              conversations: conversationResponse.conversations,
              userId: userId
            )
        );
      } on ApiException catch (apiException) {
        emit(ConversationsError(message: apiException.toString()));
      } catch (exception) {
        emit(ConversationsFatalError(message: exception.toString()));
      }
    }
  }

}