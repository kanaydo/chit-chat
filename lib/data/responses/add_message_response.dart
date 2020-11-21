import 'package:flutter_base_app/data/model/message.dart';

class AddMessageResponse {
  Message _message;
  
  AddMessageResponse.fromJSON(response) {
    _message = new Message.fromJSON(response['message']);
  }

  Message get message => _message;
}