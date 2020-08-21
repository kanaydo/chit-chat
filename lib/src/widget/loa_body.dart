import 'package:flutter/material.dart';

class LoaBody extends StatelessWidget {

  final Widget child;

  LoaBody({@required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: child,
      ),
    );
  }

}
