/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoaButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color titleColor;
  final Color borderColor;
  final Function action;
  final double minWidth;
  final EdgeInsets padding;

  LoaButton({
    @required this.title,
    this.color,
    this.titleColor,
    this.borderColor,
    this.minWidth,
    this.padding,
    @required this.action
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: padding,
      onPressed: action,
      color: color,
      minWidth: minWidth == null ? null : minWidth,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor
        ),
          borderRadius: BorderRadius.circular(50)
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: titleColor
        ),
      ),
    );
  }
}
