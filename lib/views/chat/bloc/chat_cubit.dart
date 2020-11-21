import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/model/message.dart';
import 'package:flutter_base_app/data/repository/conversation_repository.dart';
import 'package:flutter_base_app/data/responses/messages_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  var _sessionManager = SessionManager();
  var _conversationRepository = ConversationRepository();
  int _conversationId;
  int _userId;
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
  }

  void getConversationMessages() async {
    emit(ChatLoading(message: 'getting messages..'));
    try {
      MessagesResponse messagesResponse = await _conversationRepository.conversationMessages(_conversationId);
      emit(ChatIdle(messages: messagesResponse.messages, userId: _userId));
    } on ApiException catch (api) {
      emit(ChatError(message: api.toString()));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }
}
