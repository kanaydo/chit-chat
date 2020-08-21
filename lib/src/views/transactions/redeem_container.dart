import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/src/data/model/transaction.dart';
import 'package:flutter_base_app/src/views/transactions/redeem_status_badge.dart';

class RedeemContainer extends StatelessWidget {

  final Transaction transaction;
  RedeemContainer({@required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          transaction.reward == null ? '-' : transaction.reward
        ),
        SizedBox(width: 8,),
        RedeemStatusBadge(statusId: transaction.status,)
      ],
    );
  }
}
