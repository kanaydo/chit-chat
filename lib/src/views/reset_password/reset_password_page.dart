import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/views/reset_password/bloc/reset_password_bloc.dart';
import 'package:flutter_base_app/src/views/welcome/welcome_page.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_loading.dart';
import 'package:flutter_base_app/src/widget/loa_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ResetPasswordPage extends StatelessWidget {

  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: BlocProvider(
            create: (context) => ResetPasswordCubit(),
            child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
              listener: (resetPasswordListener, state) {
                if (state is ResetPasswordError) {
                  final snackBar = SnackBar(
                    content: Text(state.message),
                  );
                  Scaffold.of(resetPasswordListener).showSnackBar(snackBar);
                }
              },
              child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                builder: (resetPasswordContext, state) {
                  if (state is ResetPasswordIdle) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Reset Password',
                            style: textTheme.headline6.apply(
                                color: BASE_COLOR
                            ),
                          ),
                        ),
                        LoaTextField(label: "Email", obscureText: false, controller: _emailController),
                        LoaButton(
                            titleColor: Colors.white,
                            borderColor: Colors.white,
                            color: BASE_COLOR,
                            minWidth: double.infinity,
                            title: 'Reset', action: () {
                              String email = _emailController.text.trim();
                              resetPasswordContext.bloc<ResetPasswordCubit>().resetMemberPassword(email);
                            }
                        )
                      ],
                    );
                  } else if (state is ResetPasswordSuccess) {
                    return Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                child: FlareActor(
                                  'assets/flr/email.flr',
                                  alignment:Alignment.center,
                                  fit:BoxFit.contain,
                                  animation: 'play',
                                ),
                              ),
                              SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                    state.message,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        LoaButton(
                            titleColor: Colors.white,
                            borderColor: Colors.white,
                            color: BASE_COLOR,
                            minWidth: double.infinity,
                            title: 'Ok',
                            action: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => WelcomePage()),
                                    (Route<dynamic> route) => false,
                              );
                            }
                        )
                      ],
                    );
                  }  else if (state is ResetPasswordLoading) {
                    return LoaLoading(message: state.message);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
