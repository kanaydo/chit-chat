import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/utils/const.dart';

class LoaTextField extends StatelessWidget {

  final _focusNode = new FocusNode();

  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  LoaTextField({
    @required this.label,
    @required this.obscureText,
    @required this.controller,
    this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
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
                focusNode: _focusNode,
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
