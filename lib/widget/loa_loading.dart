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
