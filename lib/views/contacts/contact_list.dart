/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 7:11 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/arguments/contact_detail_arguments.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/core/routes.dart';
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
        indent: 32,
        endIndent: 32,
      ),
      itemBuilder: (context, index) => contactItem(contacts[index], context),
    );
  }

  Widget contactItem(Contact contact, BuildContext context) {
    var user = contact.friend;
    var arguments = ContactDetailArgument(user: user);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.contactDetail, arguments: arguments),
        child: Container(
          child: Row(
            children: [
              LoaImageBubble(url: user.image),
              SizedBox(width: 8,),
              Expanded(
                child: Text(user.name)
                ),
            ],
          )
        ),
      ),
    );
  }
}