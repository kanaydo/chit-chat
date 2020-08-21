import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/utils/const.dart';

class LoaTextFieldTemp extends StatelessWidget {

  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FocusNode focusNode;

  LoaTextFieldTemp({
    @required this.label,
    @required this.obscureText,
    @required this.controller,
    @required this.focusNode,
    this.keyboardType = TextInputType.text
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
          color: SOFT_COLOR
        ),
        //color: SOFT_COLOR,
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
                  color: BASE_COLOR
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
