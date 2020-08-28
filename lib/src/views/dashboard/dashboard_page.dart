import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/const/app_color.dart';
import 'package:flutter_base_app/src/views/dashboard/bloc/dashboard_cubit.dart';
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
          'APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.BASE_COLOR,
            letterSpacing: 1
          ),
        ),
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
                  child: Center(
                    child: Text('Hello World'),
                  ),
                );
              } else if(state is LoadingDashboard) {
                return CircularProgressIndicator();
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
