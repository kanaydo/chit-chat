/*
 * Created by Batara Kanaydo on 25/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/25/20, 9:49 AM
 */

part of 'conversation_item_cubit.dart';

@immutable
abstract class ConversationItemState {}

class ConversationItemIdle extends ConversationItemState {
  final Widget widget;
  ConversationItemIdle({this.widget});
}

class ConversationFriendIsTyping extends ConversationItemState {}