import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/const/app_color.dart';
import 'package:flutter_base_app/src/views/dashboard/bloc/dashboard_cubit.dart';
import 'package:flutter_base_app/src/views/dashboard/member_point_card.dart';
import 'package:flutter_base_app/src/views/dashboard/shimmer_loading_member_card.dart';
import 'package:flutter_base_app/src/utils/fade_animation.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {

  Future refreshPage(BuildContext context) async {
    context.bloc<DashboardCubit>().getMemberProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Pasifik',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.BASE_COLOR,
            letterSpacing: 1
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
            },
            child: Icon(
              Icons.person,
              color: AppColor.BASE_COLOR
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: GestureDetector(
              onTap: () {

              },
              child: Icon(
                Icons.history,
                color: AppColor.BASE_COLOR,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: BlocProvider(
          create: (context) => DashboardCubit(),
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (builderContext, state) {
              if (state is IdleDashboard) {
                return RefreshIndicator(
                  onRefresh: () => refreshPage(builderContext),
                  child: ListView(
                    children: [
                      FadeAnimation(
                        delay: 1,
                        widget: MemberPointCard(
                            member: state.member
                        )
                      ),
                      FadeAnimation(
                        delay: 1.2,
                        widget: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 4),
                          child: Text(
                            'Banners',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if(state is LoadingDashboard) {
                return ShimmerLoadingMemberCard();
              } else if(state is ErrorDashboard) {
                return LoaNoConnection(
                  message: state.message,
                  action: () => builderContext.bloc<DashboardCubit>().getMemberProfile(),
                );
              } else {
                return Container();
              }
            }
          ),
        ),
      ),
    );
  }
}
