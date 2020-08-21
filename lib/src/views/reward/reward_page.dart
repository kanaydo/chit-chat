import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/data/model/reward.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/utils/fade_animation.dart';
import 'package:flutter_base_app/src/views/reward/bloc/member_cubit.dart';
import 'package:flutter_base_app/src/views/reward/bloc/reward_cubit.dart';
import 'package:flutter_base_app/src/views/reward/reward_item.dart';
import 'package:flutter_base_app/src/views/reward/reward_shimmer.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_base_app/src/widget/loa_no_data.dart';
import 'package:flutter_base_app/src/widget/loa_shimmer_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RewardPage extends StatelessWidget {

  Future refreshReward(BuildContext rewardContext) async {
    rewardContext.bloc<RewardCubit>().getRewards();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: BASE_COLOR,
          ),
        ),
        actions: <Widget>[
          BlocProvider(
            create: (context) => MemberCubit(),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: BlocBuilder<MemberCubit, MemberState>(
                builder: (_, state) {
                  if (state is LoadingMember) {
                    return LoaShimmerContainer(
                        child: Text('loading')
                    );
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocProvider(
          create: (context) => RewardCubit(),
          child: FadeAnimation(
            delay: 1.2,
            widget: BlocBuilder<RewardCubit, RewardState>(
              builder: (rewardContext, state) {
                if (state is RewardLoaded) {
                  List<Reward> rewards = state.rewards;
                  return rewards.length == 0 ?
                  LoaNoData() :
                  RefreshIndicator(
                    onRefresh: () => refreshReward(rewardContext),
                    child: ListView(
                      children: [
                        FadeAnimation(
                          delay: 1,
                          widget: Text(
                            'Reward Tersedia',
                            style: textTheme.subtitle2.apply(
                                color: Colors.grey
                            ),
                          ),
                        ),
                        FadeAnimation(
                          delay: 1.2,
                          widget: ListView.builder(
                              itemCount: rewards.length,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var item = rewards[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: RewardItem(reward: item, height: screen.height),
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  );
                } else if(state is RewardLoading) {
                  return RewardShimmer();
                } else if (state is RewardFatalError) {
                  return LoaNoConnection(
                      message: state.message,
                      action: () => rewardContext.bloc<RewardCubit>().getRewards()
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
