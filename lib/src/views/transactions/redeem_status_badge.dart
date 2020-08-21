import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RedeemStatusBadge extends StatelessWidget {

  final int statusId;
  RedeemStatusBadge({@required this.statusId});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (statusId == 1) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blueAccent,
        ),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          'New Request',
          style: textTheme.caption.apply(
            color: Colors.white,
          ),
        ),
      );
    } else if (statusId == 2){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green,
        ),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          'Redeemed',
          style: textTheme.caption.apply(
            color: Colors.white,
          ),
        ),
      );
    } else if (statusId == 3){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
        ),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          'Declined',
          style: textTheme.caption.apply(
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey,
        ),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          '-',
          style: textTheme.caption.apply(
            color: Colors.white,
          ),
        ),
      );
    }
  }

}
