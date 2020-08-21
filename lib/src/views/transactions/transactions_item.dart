import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/src/data/model/transaction.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/views/transactions/point_container.dart';
import 'package:flutter_base_app/src/views/transactions/redeem_container.dart';
import 'package:flutter_base_app/src/views/transactions/sale_container.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TransactionItem extends StatelessWidget {

  final Transaction transaction;

  TransactionItem({@required this.transaction});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TimelineTile(
      alignment: TimelineAlign.left,
      indicatorStyle: const IndicatorStyle(
          width: 10,
          color: BASE_COLOR,
          padding: EdgeInsets.only(right: 8)
      ),
      topLineStyle: const LineStyle(
        color: SOFT_COLOR,
        width: 2,
      ),
      rightChild: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Container(
          decoration: BoxDecoration(
              color: SOFT_COLOR,
              borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    transaction.type == 'redeem' ? "Redeem" : "Sale",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 8,),
                  PointContainer(transaction: transaction)
                ],
              ),
              SizedBox(
                height: 8,
              ),
              transaction.type == 'redeem' ? RedeemContainer(transaction: transaction) : SaleContainer(transaction: transaction),
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 12,
                    color: Colors.grey,
                  ),
                  Text(
                    transaction.date,
                    style: textTheme.caption.apply(
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
