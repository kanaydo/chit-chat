import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/model/redeem.dart';
import 'package:flutter_base_app/src/data/model/reward.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/repository/redeem_repository.dart';
import 'package:flutter_base_app/src/data/responses/member_responses.dart';
import 'package:flutter_base_app/src/data/responses/redeem_response.dart';
import 'package:flutter_base_app/src/utils/session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'redeem_state.dart';

class RedeemCubit extends Cubit<RedeemState> {

  SessionManager _sessionManager = SessionManager();
  MemberRepository _memberRepository = MemberRepository();
  RedeemRepository redeemRepository = RedeemRepository();
  Member member;

  RedeemCubit() : super(RedeemIdle()) {
    getCurrentMember();
  }

  void getCurrentMember() async {
    int memberId = await _sessionManager.getActiveMember();
    if (memberId != 0 ) {
      fetchCurrentMemberProfile(memberId);
    }
  }

  void redeemReward(Reward reward) {
    print(member.profileCompleted);
    if (member.profileCompleted) {
      processMemberRedeem(member.id, reward.id);
    } else {
      emit(RedeemProfileNotCompleted());
      emit(RedeemIdle());
    }
  }

  void fetchCurrentMemberProfile(int memberId) async {
    emit(RedeemLoading(message: 'sedang mengambil profile..'));
    try {
      ProfileResponse response = await _memberRepository.getMemberProfile(memberId);
      this.member = response.member;
      emit(RedeemIdle());
    } on ApiException catch (apiException) {
      emit(RedeemError(message: apiException.toString()));
      emit(RedeemIdle());
    } catch (e) {
      emit(RedeemFatalError(message: e.toString()));
    }

  }

  void processMemberRedeem(int memberId, int rewardId) async {
    Map<String, dynamic> body = {
      "member_id": memberId,
      "reward_id": rewardId,
    };
    Map<String, dynamic> data = {
      "redeem": body,
    };
    emit(RedeemLoading(message: "Sedang memproses penukaran poin anda.."));
    try {
      RedeemResponse redeemResponse = await redeemRepository.redeemReward(data);
      emit(RedeemSuccess(redeem: redeemResponse.redeem));
      emit(RedeemIdle());
    } on ApiException catch(apiException) {
      emit(RedeemError(message: apiException.toString()));
      emit(RedeemIdle());
    } catch (exception) {
      emit(RedeemFatalError(message: exception.toString()));
    }
  }

  void resetPage() {
    emit(RedeemIdle());
  }

}