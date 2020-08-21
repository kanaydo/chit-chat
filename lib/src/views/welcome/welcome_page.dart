import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/src/views/login/login_page.dart';
import 'package:flutter_base_app/src/views/sign_up/sign_up_page.dart';
import 'package:flutter_base_app/src/views/welcome/welcome_banners.dart';
import 'package:flutter_base_app/src/views/welcome/bloc/welcome_cubit.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/utils/fade_animation.dart';
import 'package:flutter_base_app/src/widget/loa_body.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My App',
          style: TextStyle(
            color: BASE_COLOR
          ),
        ),
      ),
      body: LoaBody(
          child: Column(
            children: <Widget>[
              FadeAnimation(
                delay: 1,
                widget: LoaCard(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: LoaButton(
                            title: "Masuk",
                            titleColor: Colors.white,
                            borderColor: BASE_COLOR,
                            color: BASE_COLOR,
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context)=> LoginPage()
                                )
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: LoaButton(
                            title: "Daftar",
                            titleColor: BASE_COLOR,
                            borderColor: BASE_COLOR,
                            color: Colors.white,
                            action: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                delay: 1.1,
                widget: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Hot Deals',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.tags,
                        color: Colors.brown,
                        size: 12,
                      )
                    ],
                  ),
                ),
              ),
              FadeAnimation(
                delay: 1.2,
                widget: BlocProvider(
                  create: (context) => WelcomeCubit(),
                  child: WelcomeBanners(),
                ),
              )
            ],
          )
      ),
    );
  }
}
 