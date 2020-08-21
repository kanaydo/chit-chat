import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/reward.dart';
import 'package:flutter_base_app/src/data/repository/reward_repository.dart';
import 'package:flutter_base_app/src/data/responses/rewards_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'reward_state.dart';

class RewardCubit extends Cubit<RewardState> {

  RewardRepository rewardRepository = RewardRepository();

  RewardCubit() : super(null) {
   getRewards();
  }


  void getRewards() async {
    emit(RewardLoading(message: 'sedang mengambil daftar reward'));
    try {
      RewardsResponse rewardsResponse = await rewardRepository.getRewardList();
      emit(RewardLoaded(rewards: rewardsResponse.rewards));
    } on ApiException catch (api) {
      emit(RewardError(message: api.toString()));
    } catch (e) {
      emit(RewardFatalError(message: e.toString()));
    }
  }
}
