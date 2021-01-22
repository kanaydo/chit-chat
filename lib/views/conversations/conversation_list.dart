/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 7:09 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/views/conversations/conversation_item.dart';
import 'package:flutter_base_app/widget/loa_no_data.dart';

class ConversationList extends StatelessWidget {
  final List<Conversation> conversations;
  final int userId;

  ConversationList({this.conversations, this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: conversations.length == 0
          ? Center(
              child: LoaNoData(),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: AppColor.SOFT_COLOR,
                  ),
              itemCount: conversations.length,
              itemBuilder: (context, index) => ConversationItem(
                    userId: userId,
                    conversation: conversations[index],
                  )),
    );
  }
}
