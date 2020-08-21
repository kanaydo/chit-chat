import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/core/blocs/home/home_cubit.dart';
import 'package:flutter_base_app/src/views/dashboard/dashboard_page.dart';
import 'package:flutter_base_app/src/views/welcome/welcome_page.dart';
import 'package:flutter_base_app/src/widget/loa_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
          builder: (builderContext, state) {
            if (state is CheckAuthenticate) {
              return Scaffold(
                body: LoaLoading(message: state.message),
              );
            } else if (state is Authenticated) {
              return DashboardPage();
            } else if (state is UnAuthenticated) {
              return WelcomePage();
            } else {
              return Scaffold(
                body: Container(),
              );
            }
          }
      ),
    );
  }
}