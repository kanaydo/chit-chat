import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/utils/fade_animation.dart';
import 'package:flutter_base_app/src/views/login/login_page.dart';
import 'package:flutter_base_app/src/views/profile/bloc/profile_cubit.dart';
import 'package:flutter_base_app/src/views/profile/edit_profile/edit_profile_page.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_card.dart';
import 'package:flutter_base_app/src/widget/loa_loading.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {

  Future<void> _showConfirmDialog(BuildContext mainContext) async {
    return showDialog<void>(
      context: mainContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Anda yakin ingin keluar?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'batal',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('yakin'),
              onPressed: () => mainContext.bloc<ProfileCubit>().logoutCurrentMember(),
            ),
          ],
        );
      },
    );
  }


  Future refreshProfile(BuildContext blocContext) async {
    blocContext.bloc<ProfileCubit>().refreshProfile();
  }



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BASE_COLOR,
            ),
            onPressed: () => Navigator.pop(context)
        ),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit(),
        child: Container(
          width: screen.width,
          height: screen.height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileError) {
              } else if (state is LogoutSuccessState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                );
              }
            },
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (profileContext, state) {
                if (state is ProfileIdle) {
                  var member = state.member;
                  var province = state.member.province;
                  var city = state.member.city;
                  return RefreshIndicator(
                    onRefresh: () => refreshProfile(profileContext),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              FadeAnimation(
                                delay: 1,
                                widget: Center(
                                  child: CircleAvatar(
                                    radius: 42,
                                    backgroundColor: BASE_COLOR,
                                    child: CircleAvatar(
                                      radius: 40,
                                      child: Icon(
                                        Icons.person,
                                        color: BASE_COLOR,
                                        size: 60,
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.1,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Center(
                                      child: Text(
                                          member.displayName,
                                        style: textTheme.headline6,
                                      )
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.2,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: InkWell(
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage())),
                                      child: Center(
                                          child: Text(
                                              'Perbaharui Profile',
                                            style: textTheme.button.apply(
                                              color: BASE_COLOR
                                            ),
                                          )
                                      )
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.2,
                                widget: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: LoaCard(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    'Poin',
                                                    style: textTheme.overline.apply(
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                  Text(
                                                    '${state.member.currentPoints}',
                                                    style: textTheme.bodyText1,
                                                  )
                                                ],
                                              )
                                          ),
                                          Container(
                                              height: 50,
                                              child: VerticalDivider(
                                                color: Colors.grey,
                                              )
                                          ),
                                          Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    'Berlaku Hingga',
                                                    style: textTheme.overline.apply(
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                  Text(
                                                    state.member.validUntil == null ? '-' : state.member.validUntil,
                                                    style: textTheme.bodyText1,
                                                  )
                                                ],
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.3,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Email',
                                        style: textTheme.overline.apply(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        state.member.email == null ? "-" : state.member.email,
                                        style: textTheme.bodyText1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.4,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Nomor Telepon',
                                        style: textTheme.overline.apply(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        state.member.phoneNumber == null ? "-" : state.member.phoneNumber,
                                        style: textTheme.bodyText1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.4,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Akun Instagram',
                                        style: textTheme.overline.apply(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        state.member.instagram == null ? "-" : state.member.instagram,
                                        style: textTheme.bodyText1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.4,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Tahun Lahir',
                                        style: textTheme.overline.apply(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        state.member.birthYear == null ? "-" : '${state.member.birthYear}',
                                        style: textTheme.bodyText1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.4,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Jenis Kelamin',
                                        style: textTheme.overline.apply(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        state.member.genderId == null ? "-" : '${state.member.gender}',
                                        style: textTheme.bodyText1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.5,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Alamat',
                                        style: textTheme.overline.apply(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        state.member.address == null ? "-" : state.member.address,
                                        style: textTheme.bodyText1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              FadeAnimation(
                                delay: 1.6,
                                widget: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Detail Alamat',
                                        style: textTheme.overline.apply(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        member.regionAddress(),
                                        style: textTheme.bodyText1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FadeAnimation(
                          delay: 1.6,
                          widget: LoaButton(
                              minWidth: double.infinity,
                              color: SOFT_COLOR,
                              titleColor: BASE_COLOR,
                              borderColor: SOFT_COLOR,
                              title: "Keluar",
                              action: () => _showConfirmDialog(profileContext)
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is ProfileLoading) {
                  return LoaLoading(message: state.message,);
                } else if(state is ProfileFatalError) {
                  return LoaNoConnection(
                      message: state.message,
                      action: () => profileContext.bloc<ProfileCubit>().refreshProfile()
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
