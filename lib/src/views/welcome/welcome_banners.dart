import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/src/views/welcome/banner_item.dart';
import 'package:flutter_base_app/src/views/welcome/bloc/welcome_cubit.dart';
import 'package:flutter_base_app/src/utils/banner_shimmer.dart';
import 'package:flutter_base_app/src/widget/loa_no_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeBanners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<WelcomeCubit, WelcomeState>(
          builder: (_, state) {
            if (state is LoadingBanner) {
              return Center(
                  child: BannerShimmer(height: height / 3)
              );
            } else if (state is IdleBanner) {
              final banners = state.banners;
              return banners.length == 0 ?
              LoaNoData() :
              Column(
                children: <Widget>[
                  ListView.builder(
                      itemCount: banners.length,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => BannerItem(banner: banners[index], height: height / 3)
                  ),
                ],
              );
            } else if(state is ErrorBanner) {
              return Center(
                  child: Text(state.message)
              );
            }
            else {
              return Container();
            }
          }
    );
  }
}
 