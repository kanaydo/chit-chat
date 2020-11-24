/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/22/20, 2:19 PM
 */

import 'package:flutter/material.dart';

class LoaText extends StatelessWidget {
  final String title;
  final String content;

  LoaText({this.content, this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: textTheme.overline.apply(color: Colors.grey),
          ),
          Text(
            content,
            style: textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
