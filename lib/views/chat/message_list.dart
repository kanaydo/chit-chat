import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/data/model/message.dart';
import 'package:flutter_base_app/widget/loa_no_data.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;
  final int userId;
  MessageList({this.messages, this.userId});
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Center(
      child: messages.length == 0
          ? LoaNoData()
          : ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) =>
                  messageItem(messages[index], size),
            ),
    ));
  }

  Widget messageItem(Message message, Size size) {
    BorderRadius rightBubble = BorderRadius.only(
      topRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      topLeft: Radius.circular(20)
    );
    BorderRadius leftBubble = BorderRadius.only(
      topRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    );

    return Align(
      alignment: message.userId == userId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          width: size.width / 1.2,
          decoration: BoxDecoration(
            color: message.userId == userId ? AppColor.SOFT_COLOR : AppColor.BASE_COLOR,
            borderRadius: message.userId == userId ? rightBubble : leftBubble
          ),
          child: Text(
            '${message.content}',
            style: TextStyle(
              color: message.userId == userId ? AppColor.BASE_COLOR : AppColor.SOFT_COLOR
            ),
            textAlign:
                message.userId == userId ? TextAlign.end : TextAlign.start,
          )),
    );
  }
}
