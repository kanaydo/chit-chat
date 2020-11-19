import 'package:flutter/material.dart';
import 'package:flutter_base_app/data/model/conversation.dart';
import 'package:flutter_base_app/data/model/user.dart';

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
          : ListView.builder(
              shrinkWrap: true,
              itemCount: conversations.length,
              itemBuilder: (context, index) =>
                  conversation(conversations[index])),
    );
  }

  Widget conversation(Conversation conversation) {
    User friend = conversation.userOne.id == userId
        ? conversation.userTwo
        : conversation.userTwo;
    return Row(
      children: [
        Container(
            width: 30,
            height: 30,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                        friend.image
                    )
                ),
                border: Border.all(
                    width: 1.5,
                    color: Colors.orange
                )
            )
        ),
        Text(friend.name),
      ],
    );
  }
}
