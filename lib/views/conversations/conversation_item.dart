/*
 * Created by Batara Kanaydo on 25/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/25/20, 9:42 AM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/arguments/chat_arguments.dart';
import 'package:flutter_base_app/core/routes.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/views/conversations/bloc/conversation_item_cubit.dart';
import 'package:flutter_base_app/widget/loa_image_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationItem extends StatelessWidget {
  final int userId;
  final Conversation conversation;

  ConversationItem({this.userId, this.conversation});

  @override
  Widget build(BuildContext context) {
    User friend = conversation.userOne.id == userId
        ? conversation.userTwo
        : conversation.userOne;
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => ConversationItemCubit(conversation, friend, textTheme),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, Routes.chat,
              arguments:
                  ChatArgument(friend: friend, conversation: conversation)),
          child: Row(
            children: [
              LoaImageBubble(url: friend.image),
              SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(friend.name),
                  BlocBuilder<ConversationItemCubit, ConversationItemState>(
                      builder: (builderContext, state) {
                        if (state is ConversationItemIdle) {
                          return Container(
                            child: state.widget,
                          );
                        } else if (state is ConversationFriendIsTyping) {
                          return Container();
                        } else {
                          return Container();
                        }
                      }
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
