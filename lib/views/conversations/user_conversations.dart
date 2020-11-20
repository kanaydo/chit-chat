import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/widget/loa_image_bubble.dart';

class UserConversations extends StatelessWidget {

  final List<Conversation> conversations;
  final int userId;

  UserConversations({this.conversations, this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: conversations.length == 0
          ? Center(
              child: Text('No message yet!'),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: AppColor.SOFT_COLOR,
                  ),
              itemCount: conversations.length,
              itemBuilder: (context, index) =>
                  conversationItem(conversations[index])),
    );
  }

  Widget conversationItem(Conversation conversation) {
    User friend = conversation.userOne.id == userId
        ? conversation.userTwo
        : conversation.userTwo;
    return Row(
      children: [
        LoaImageBubble(url: friend.image),
        SizedBox(
          width: 8.0,
        ),
        Text(friend.name),
      ],
    );
  }
}
