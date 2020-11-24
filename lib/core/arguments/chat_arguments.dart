/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 8:25 PM
 */

import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/model/user.dart';

class ChatArgument {
  final Conversation conversation;
  final User friend;
  ChatArgument({this.conversation, this.friend});
}