import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/core/routes.dart';
import 'package:flutter_base_app/views/profile/bloc/profile_cubit.dart';
import 'package:flutter_base_app/views/profile/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  Future<void> _showConfirmDialog(BuildContext blocContext) async {
    return showDialog<void>(
      context: blocContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('sure wanna sign out?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'nope',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('sure'),
              onPressed: () => blocContext.read<ProfileCubit>().signOutUser(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (profileProviderContext) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (listenerContext, state) {
          if (state is ProfileSuccessSignOut) {
            Navigator.pushNamedAndRemoveUntil(
                listenerContext, Routes.signIn, (route) => false);
          }
        },
        builder: (builderContext, state) {
          if (state is ProfileLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is ProfileIdle) {
            return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: AppColor.BASE_COLOR),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    InkWell(
                      onTap: () => _showConfirmDialog(builderContext),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Icon(Icons.logout),
                      ),
                    )
                  ],
                ),
                body: UserProfile(user: state.user));
          } else if (state is ProfileError) {
            return Center(
              child: Scaffold(body: Text(state.message)),
            );
          } else if (state is ProfileFatalError) {
            return Scaffold(body: Center(child: Text(state.message)));
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        },
      ),
    );
  }
}
