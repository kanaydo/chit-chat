import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/core/const/strings.dart';
import 'package:flutter_base_app/core/routes.dart';
import 'package:flutter_base_app/utils/fade_animation.dart';
import 'package:flutter_base_app/views/sign_in/bloc/sign_in_cubit.dart';
import 'package:flutter_base_app/widget/loa_button.dart';
import 'package:flutter_base_app/widget/loa_loading.dart';
import 'package:flutter_base_app/widget/loa_no_connection.dart';
import 'package:flutter_base_app/widget/loa_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {

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
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.dashboard, (route) => false);
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                          delay: 1,
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Strings.LABEL_SIGN_IN,
                                style: textTheme.headline4
                                    .apply(color: AppColor.BASE_COLOR),
                              ),
                              Text(
                                Strings.SIGN_IN_TO_CONTINUE,
                                style: textTheme.overline
                                    .apply(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        new LoaTextField(
                            label: Strings.LABEL_EMAIL,
                            controller: _emailController,
                            focusNode: _emailFocusNode
                        ),
                        new LoaTextField(
                          label: Strings.LABEL_PASSWORD,
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          obscureText: true
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FadeAnimation(
                          delay: 1.3,
                          widget: LoaButton(
                              title: Strings.COMMAND_SIGN_IN,
                              color: AppColor.BASE_COLOR,
                              titleColor: Colors.white,
                              borderColor: AppColor.BASE_COLOR,
                              minWidth: double.infinity,
                              action: () {
                                var email = _emailController.text;
                                var password = _passwordController.text;
                                loginBlocContext
                                    .bloc<SignInCubit>()
                                    .loginUser(email, password);
                              }),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FadeAnimation(
                          delay: 1.4,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                Strings.LABEL_NOT_HAVING_ACCOUNT,
                                style:
                                  textTheme.caption.apply(color: Colors.grey
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              InkWell(
                                onTap: () =>
                                    Navigator.pushNamed(context, Routes.signUp),
                                child: Text(
                                  Strings.LABEL_SIGN_UP,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.BASE_COLOR
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (loginState is SignInLoading) {
                  return LoaLoading(message: loginState.message);
                } else if (loginState is SignInFatalError) {
                  return LoaNoConnection(
                    message: loginState.message,
                    action: () =>
                        loginBlocContext.bloc<SignInCubit>().resetForm(),
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ),
        ));
  }
}
