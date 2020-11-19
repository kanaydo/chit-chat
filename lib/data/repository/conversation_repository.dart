import 'package:dio/dio.dart';
import 'package:flutter_base_app/data/responses/conversation_response.dart';
import '../../core/network/api_client.dart';
import '../../core/network/app_exception.dart';

class ConversationRepository extends ApiClient {

  userConversations(int userId) async {
    try {
      var response = await dio.get('conversations?user_id=$userId');
      return ConversationResponse.fromJSON(response.data);
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        print(e.toString());
        throw Exception(e.toString());
      }
    }
  }
}