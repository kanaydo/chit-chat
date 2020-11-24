/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 7:06 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/arguments/contact_detail_arguments.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/views/profile/user_profile.dart';

class ContactDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ContactDetailArgument argument = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: AppColor.BASE_COLOR
        ),
      ),
      body: UserProfile(user: argument.user)
    );
  }
}
