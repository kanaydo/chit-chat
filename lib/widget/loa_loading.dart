/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

import 'package:flutter/material.dart';

class LoaLoading extends StatelessWidget {
  final String message;

  LoaLoading({@required this.message});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screen = MediaQuery.of(context).size;
    return Container(
      height: screen.height,
      width: screen.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 16,),
          Text(
            message,
            style: textTheme.overline.apply(
                color: Colors.grey
            ),
          )
        ],
      ),
    );
  }
}
