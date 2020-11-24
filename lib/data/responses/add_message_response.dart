/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 11:14 PM
 */

import 'package:flutter_base_app/data/model/message.dart';

class AddMessageResponse {
  Message _message;
  
  AddMessageResponse.fromJSON(response) {
    _message = new Message.fromJSON(response['message']);
  }

  Message get message => _message;
}