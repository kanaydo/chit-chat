import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/routes.dart';
import 'package:flutter_base_app/src/core/session_manager.dart';
import 'package:flutter_base_app/src/core/strings.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/utils/fade_animation.dart';
import 'package:flutter_base_app/src/views/sign_in/sign_in_page.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_loading.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_app/src/views/sign_up/bloc/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();
  final SessionManager _sessionManager = SessionManager();


  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: BASE_COLOR,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: screen.height,
        width: screen.width,
        child: FadeAnimation(
            delay: 1.2,
            widget: BlocProvider(
              create: (context) => SignUpCubit(),
              child: BlocListener<SignUpCubit, SignUpState>(
                listener: (signUpListener, state) {
                  if (state is SignUpSuccess) {
                    var result = state.signUpResponse.result;
                    var member = state.signUpResponse.member;
                    if(result == true && member.id != null) {
                      _sessionManager.setActiveMember(member);
                      Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (route) => false);
                    }
                  } else if (state is SignUpError) {
                    final snackBar = SnackBar(
                      content: Text(state.message),
                    );
                    Scaffold.of(signUpListener).showSnackBar(snackBar);
                  }
                },
                child: BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (signUpBuilder, state) {
                      if (state is SignUpIdle) {
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
                                    Strings.LABEL_SIGN_UP,
                                    style: textTheme.headline4.apply(
                                        color: BASE_COLOR
                                    ),
                                  ),
                                  Text(
                                    Strings.LABEL_CREATE_NEW_ACCOUNT,
                                    style: textTheme.overline.apply(
                                        color: Colors.grey
                                    ),
                                  ),
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
                                      Strings.LABEL_EMAIL,
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
                                _passwordFocusNode.requestFocus();
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
                                      Strings.LABEL_PASSWORD,
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
                            Column(
                              children: <Widget>[
                                LoaButton(
                                    color: BASE_COLOR,
                                    title: Strings.COMMAND_SIGN_UP,
                                    titleColor: Colors.white,
                                    minWidth: double.infinity,
                                    borderColor: BASE_COLOR,
                                    action: () {
                                      String email = _emailController.text.trim();
                                      String password = _passwordController.text.trim();
                                      signUpBuilder.bloc<SignUpCubit>().signUpUser(email, password);
                                    }
                                ),
                                SizedBox(height: 8.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      Strings.LABEL_HAVING_ACCOUNT_ALREADY,
                                      style: textTheme.caption.apply(
                                          color: Colors.grey
                                      ),
                                    ),
                                    SizedBox(width: 4,),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                                      },
                                      child: Text(
                                        Strings.COMMAND_SIGN_IN,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      } else if (state is SignUpLoading) {
                        return LoaLoading(
                          message: state.message,
                        );
                      } else if (state is SignUpFatalError) {
                        return LoaNoConnection(
                            message: state.message,
                            action: () => signUpBuilder.bloc<SignUpCubit>().resetForm()
                        );
                      }else {
                        return Container();
                      }
                    }
                ),
              ),
            )
        ),
      ),
    );
  }
}