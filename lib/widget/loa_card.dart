import 'package:flutter/material.dart';

class LoaCard extends StatelessWidget {
  final Widget child;

  LoaCard({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }

}
