import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/const/app_color.dart';
import 'package:flutter_base_app/src/views/dashboard/bloc/dashboard_cubit.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_base_app/src/widget/loa_reload.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class DashboardPage extends StatelessWidget {

  Future refreshPage(BuildContext context) async {
    context.bloc<DashboardCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.BASE_COLOR,
          ),
        ),
        actions: [
          LoaReload(onTap: null)
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
                  child: Center(child: Text('Hello World')),
                );
              } else if(state is LoadingDashboard) {
                return CircularProgressIndicator();
              } else if(state is ErrorDashboard) {
                return LoaNoConnection(
                  message: state.message,
                  action: () => builderContext.bloc<DashboardCubit>().getUserProfile(),
                );
              } else {
                return Container();
              }
            }
          ),
        ),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: 1,
          inactiveColor: Colors.grey,
          indicatorColor: AppColor.BASE_COLOR,
          activeColor: AppColor.BASE_COLOR,
          onTap: (index){
            print("Selected Index: $index");
          },
          items: [
            TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
            TitledNavigationBarItem(title: Text('Bag'), icon: Icons.card_travel),
            TitledNavigationBarItem(title: Text('Profile'), icon: Icons.person_outline),
          ]
      )
    );
  }
}
