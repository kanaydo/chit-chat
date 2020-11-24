/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoaNoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: screen.height,
      width: screen.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            child: FlareActor(
              'assets/flr/empty.flr',
              alignment:Alignment.center,
              fit:BoxFit.contain,
              animation: 'empty',
            ),
          ),
          Text(
            'tidak ada data ditemukan',
            style: textTheme.overline.apply(
                color: Colors.grey
            ),
          )
        ],
      ),
    );
  }
}
