import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';

class LoaImageBubble extends StatelessWidget {

  final String url;
  LoaImageBubble({ this.url });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 30,
        height: 30,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(url)),
            border: Border.all(width: 2, color: AppColor.SOFT_COLOR)));
  }
}
