import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/data/model/redeem.dart';
import 'package:flutter_base_app/src/data/model/reward.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/utils/messages.dart';
import 'package:flutter_base_app/src/views/profile/edit_profile/edit_profile_page.dart';
import 'package:flutter_base_app/src/views/redeem_confirm/bloc/redeem_cubit.dart';
import 'package:flutter_base_app/src/views/reward/bloc/member_cubit.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_card.dart';
import 'package:flutter_base_app/src/widget/loa_loading.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_base_app/src/widget/loa_shimmer_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemPage extends StatelessWidget {

  final Reward reward;

  RedeemPage({@required this.reward});

  void _showDialogResult(BuildContext context, bool isError, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: FlareActor(
                          isError ? 'assets/flr/error.flr' : 'assets/flr/success.flr',
                          alignment:Alignment.center,
                          fit:BoxFit.contain,
                          animation: 'play',
                        ),
                      ),
                      Text(message)
                    ],
                  ),
                  SizedBox(height: 32,),
                  LoaButton(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      color: BASE_COLOR,
                      minWidth: double.infinity,
                      borderColor: BASE_COLOR,
                      titleColor: Colors.white,
                      title: 'Ok',
                      action: () {
                        Navigator.pop(context);
                      }
                  )
                ],
              ),
            ),
          );
      }
    );
  }

  void _showDialogCompleteProfile(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: FlareActor(
                          'assets/flr/empty.flr',
                          alignment:Alignment.center,
                          fit:BoxFit.contain,
                          animation: 'empty',
                        ),
                      ),
                      Text(
                        "Sepertinya informasi profil anda belum lengkap, mohon lengkapi terlebih dahulu untuk bisa melanjutkan.",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(height: 32,),
                  LoaButton(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      color: BASE_COLOR,
                      minWidth: double.infinity,
                      borderColor: BASE_COLOR,
                      titleColor: Colors.white,
                      title: 'Lengkapi Profil', action: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfilePage()));
                      }
                  )
                ],
              ),
            ),
          );
        }
    );
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
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          BlocProvider(
            create: (context) => MemberCubit(),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: BlocBuilder<MemberCubit, MemberState>(
                builder: (_, state) {
                  if (state is LoadingMember) {
                    return LoaShimmerContainer(child: Text('loading'));
                  } else if (state is IdleMember) {
                    return Row(
                      children: <Widget>[
                        Text(
                          '${state.member.currentPoints}',
                          style: textTheme.subtitle2.apply(
                              color: BASE_COLOR
                          ),
                        ),
                        Text(
                          'poin',
                          style: textTheme.overline.apply(
                              color: Colors.grey
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: screen.height,
        width: screen.width,
        child: BlocProvider(
          create: (context) => RedeemCubit(),
          child: BlocListener<RedeemCubit, RedeemState>(
            listener: (listenerContext, state) {
              if (state is RedeemError) {
                _showDialogResult(context, true, state.message);
              } else if (state is RedeemSuccess) {
                Redeem redeem = state.redeem;
                if(redeem.id != null) {
                  _showDialogResult(context, false, "yay");
                }
              } else if (state is RedeemProfileNotCompleted) {
                _showDialogCompleteProfile(context);
              }
            },
            child: BlocBuilder<RedeemCubit, RedeemState>(
              builder: (redeemBlocContext, state) {
                if (state is RedeemIdle) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            LoaCard(
                                child: Container(
                                  height: screen.height / 2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(reward.imageUrl),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Center(
                                child: Text(
                                  reward.title,
                                  style: textTheme.headline6,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Point Dibutuhkan',
                                            style: textTheme.overline.apply(
                                                color: Colors.grey
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${reward.requiredPoint}',
                                                style: textTheme.bodyText1,
                                              ),
                                              SizedBox(width: 4,),
                                              Text(
                                                'points',
                                                style: textTheme.caption.apply(
                                                    color: Colors.grey
                                                ),
                                              ),
                                            ],
                                          ),
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
                                            'Tersedia Sampai',
                                            style: textTheme.overline.apply(
                                                color: Colors.grey
                                            ),
                                          ),
                                          Text(
                                            reward.validDate,
                                            style: textTheme.bodyText1,
                                          )
                                        ],
                                      )
                                  )
                                ],
                              ),
                            ),
                            Text(
                                'Deskripsi',
                                style: textTheme.bodyText2
                            ),
                            SizedBox(height: 8,),
                            Text(
                              reward.description,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54
                              ),
                            ),
                          ],
                        ),
                      ),
                      LoaButton(
                          title: Messages.REDEEM_NOW_CMD,
                          minWidth: double.infinity,
                          titleColor: Colors.white,
                          color: BASE_COLOR,
                          borderColor: BASE_COLOR,
                          action: () => redeemBlocContext.bloc<RedeemCubit>().redeemReward(reward)
                      )

                    ],
                  );
                } else if (state is RedeemLoading){
                  return LoaLoading(message: state.message);
                } else if(state is RedeemFatalError) {
                  return LoaNoConnection(
                      message: state.message,
                      action: () => redeemBlocContext.bloc<RedeemCubit>().resetPage()
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