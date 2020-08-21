import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/data/model/transaction.dart';

class SaleContainer extends StatelessWidget {

  final Transaction transaction;
  SaleContainer({@required this.transaction});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      children: [
        Text.rich(
          TextSpan(
            text: 'Weight ',
            style: textTheme.bodyText2.apply(
              fontStyle: FontStyle.italic
            ),
            children: <TextSpan>[
              TextSpan(
                  text: transaction.weight,
                  style: textTheme.bodyText2.apply(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
              ),
              // can add more TextSpans here...
            ],
          ),
        ),
        SizedBox(width: 16,),
        Text.rich(
          TextSpan(
            text: 'Price: ',
            style: textTheme.bodyText2.apply(
                fontStyle: FontStyle.italic
            ),
            children: <TextSpan>[
              TextSpan(
                  text: transaction.price,
                  style: textTheme.bodyText2.apply(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
              ),
              // can add more TextSpans here...
            ],
          ),
        )
      ],
    );
  }
}
