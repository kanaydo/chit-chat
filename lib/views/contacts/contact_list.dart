import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/data/model/contact.dart';
import 'package:flutter_base_app/widget/loa_image_bubble.dart';

class ContactList extends StatelessWidget {

  final List<Contact> contacts;
  ContactList({ this.contacts });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (context, index) => Divider(
        color: AppColor.SOFT_COLOR,
      ),
      itemBuilder: (context, index) => contactItem(contacts[index]),
    );
  }

  Widget contactItem(Contact contact) {
    var user = contact.friend;
    return Container(
      child: Row(
        children: [
          LoaImageBubble(url: user.image),
          Expanded(
            child: Text(user.name)
            ),
        ],
      )
    );
  }
}