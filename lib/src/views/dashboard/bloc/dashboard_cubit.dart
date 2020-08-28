import 'package:flutter_base_app/src/core/network/app_exception.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/dashboard_response.dart';
import 'package:flutter_base_app/src/core/session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState>{

  SessionManager sessionManager = SessionManager();
  MemberRepository memberRepository = MemberRepository();
  Member member;

  DashboardCubit() : super(null) {
    getMemberProfile();
  }

  void getMemberProfile() async {
    int memberId = await sessionManager.getActiveMember();
    if (memberId != 0) {
      fetchCurrentMemberProfile(memberId);
    }
  }
  
  void fetchCurrentMemberProfile(int memberId) async {
    emit(LoadingDashboard());
    try {
      DashboardResponse response = await memberRepository.getMember(memberId);
      this.member = response.member;
    } on ApiException catch (apiException) {
      emit(ErrorDashboard(apiException.toString()));
    } catch (e) {
      emit(ErrorDashboard(e.toString()));
    }
    emit(IdleDashboard(member: member));
  }

}