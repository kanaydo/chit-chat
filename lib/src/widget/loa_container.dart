import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/const/app_color.dart';

class LoaContainer extends StatelessWidget {

  final Widget child;

  LoaContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.SOFT_COLOR
      ),
      //color: SOFT_COLOR,
      child: child,
    );
  }
}
