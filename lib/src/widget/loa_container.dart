import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/utils/const.dart';

class LoaContainer extends StatelessWidget {

  final Widget child;

  LoaContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: SOFT_COLOR
      ),
      //color: SOFT_COLOR,
      child: child,
    );
  }
}
