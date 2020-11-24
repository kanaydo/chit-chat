/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';

class LoaTextField extends StatelessWidget {

  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FocusNode focusNode;

  LoaTextField({
    @required this.label,
    @required this.controller,
    @required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.SOFT_COLOR
        ),
        child: Row(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Colors.grey
              ),
            ),
            SizedBox(width: 8,),
            new Flexible(
              child: new TextField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                focusNode: focusNode,
                style: TextStyle(
                  color: AppColor.BASE_COLOR
                ),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    border: InputBorder.none
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
