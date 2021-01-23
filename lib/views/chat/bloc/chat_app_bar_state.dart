/*
 * Created by Batara Kanaydo on 25/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/25/20, 9:49 AM
 */

part of 'chat_app_bar_cubit.dart';

@immutable
abstract class ChatAppBarState {}

class ChatAppBarIdle extends ChatAppBarState {
  final Widget widget;
  ChatAppBarIdle({this.widget});
}