import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/const/app_color.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';

class LoaNoConnection extends StatelessWidget {
  final String message;
  final Function action;

  LoaNoConnection({@required this.message, @required this.action});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  child: FlareActor(
                    'assets/flr/connection_error.flr',
                    alignment:Alignment.center,
                    fit:BoxFit.contain,
                    animation: 'idle',
                  ),
                ),
                Text(
                  "Terjadi kesalahan pada koneksi anda",
                  style: textTheme.bodyText2,
                ),
                Text(
                  "Mohon cek ulang koneksi anda, dan coba lagi!",
                  style: textTheme.caption,
                ),
                /*Text(
                  message,
                  textAlign: TextAlign.center,
                  style: textTheme.overline.apply(
                      color: Colors.grey,
                  ),
                )*/
              ],
            ),
          ),
          LoaButton(
              minWidth: double.infinity,
              color: AppColor.BASE_COLOR,
              titleColor: Colors.white,
              borderColor: Colors.white,
              title: "Coba Lagi",
              action: action
          )
        ],
      ),
    );
  }
}
