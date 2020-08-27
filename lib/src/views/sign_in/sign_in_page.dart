import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/src/utils/fade_animation.dart';
import 'package:flutter_base_app/src/core/session_manager.dart';
import 'package:flutter_base_app/src/views/dashboard/dashboard_page.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/views/sign_in/bloc/sign_in_cubit.dart';
import 'package:flutter_base_app/src/views/sign_up/sign_up_page.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_loading.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {

  final SessionManager _sessionManager = SessionManager();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: BASE_COLOR,
            ),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: screen.height,
        width: screen.width,
        child: BlocProvider(
          create: (context) => SignInCubit(),
          child: BlocListener<SignInCubit, SignInState>(
            listener: (loginBlocContext, state) {
              if (state is SignInSuccess) {
                var member = state.member;
                _sessionManager.setActiveMember(member);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                      (Route<dynamic> route) => false,
                );
              } else if (state is SignInError) {
                final snackBar = SnackBar(
                  content: Text(state.message),
                );
                Scaffold.of(loginBlocContext).showSnackBar(snackBar);
              }
            },
            child: BlocBuilder<SignInCubit, SignInState>(
                builder: (loginBlocContext, loginState) {
                  if (loginState is SignInIdle) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                          delay: 1,
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'SignIn',
                                style: textTheme.headline4.apply(
                                    color: BASE_COLOR
                                ),
                              ),
                              Text(
                                'Masuk untuk melanjutkan',
                                style: textTheme.overline.apply(
                                    color: Colors.grey
                                ),
                              )
                            ],
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            _emailFocusNode.requestFocus();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: SOFT_COLOR
                            ),
                            //color: SOFT_COLOR,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Email/Phone",
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                SizedBox(width: 8,),
                                new Flexible(
                                  child: new TextField(
                                    controller: _emailController,
                                    focusNode: _emailFocusNode,
                                    style: TextStyle(
                                        color: BASE_COLOR
                                    ),
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            _emailFocusNode.requestFocus();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: SOFT_COLOR
                            ),
                            //color: SOFT_COLOR,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                SizedBox(width: 8,),
                                new Flexible(
                                  child: new TextField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: BASE_COLOR
                                    ),
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        FadeAnimation(
                          delay: 1.3,
                          widget: LoaButton(
                              title: 'login',
                              color: BASE_COLOR,
                              titleColor: Colors.white,
                              borderColor: BASE_COLOR,
                              minWidth: double.infinity,
                              action: () {
                                var email = _emailController.text;
                                var password = _passwordController.text;
                                loginBlocContext.bloc<SignInCubit>().loginUser(
                                    email, password);
                              }
                          ),
                        ),
                        SizedBox(height: 16,),
                        FadeAnimation(
                          delay: 1.4,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Belum punya akun?',
                                style: textTheme.caption.apply(
                                    color: Colors.grey
                                ),
                              ),
                              SizedBox(width: 4,),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                                },
                                child: Text(
                                  'Daftar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (loginState is SignInLoading) {
                    return LoaLoading(message: loginState.message);
                  } else if(loginState is SignInFatalError) {
                    return LoaNoConnection(
                      message: loginState.message,
                      action: () => loginBlocContext.bloc<SignInCubit>().resetForm(),
                    );
                  } else {
                    return Container();
                  }
                }
            ),
          ),
        ),
      )
    );
  }
}