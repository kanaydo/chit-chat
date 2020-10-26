import 'package:flutter/material.dart';

class LoaReload extends StatelessWidget {
  final Function onTap;
  LoaReload({@required this.onTap});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Wrap(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.grey,
                  ),
                  Text(
                    'tap to reload',
                    style: textTheme.caption.apply(
                        color: Colors.grey
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    )
    ;
  }
}
