import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/data/model/transaction.dart';

class PointContainer extends StatelessWidget {

  final Transaction transaction;
  PointContainer({@required this.transaction});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (transaction?.type == 'redeem') {
      return Container(
        child: Text(
          '(- ${transaction?.points})',
          style: textTheme.caption.apply(
            color: Colors.red,
            fontStyle: FontStyle.italic
          ),
        ),
      );
    } else {
      return Container(
        child: Text(
          '(+ ${transaction?.points})',
          style: textTheme.caption.apply(
              color: Colors.green,
              fontStyle: FontStyle.italic
          ),
        ),
      );
    }

  }
}
