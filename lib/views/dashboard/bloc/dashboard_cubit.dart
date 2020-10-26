import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/data/repository/member_repository.dart';
import 'package:flutter_base_app/data/responses/dashboard_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState>{

  var sessionManager = SessionManager();
  var memberRepository = MemberRepository();
  User user;

  DashboardCubit() : super(null) {
    getUserProfile();
  }

  void getUserProfile() async {
    int memberId = await sessionManager.getActiveMember();
    if (memberId != 0) {
      fetchCurrentUserProfile(memberId);
    }
  }
  
  void fetchCurrentUserProfile(int memberId) async {
    emit(LoadingDashboard());
    try {
      DashboardResponse response = await memberRepository.getUser(memberId);
      this.user = response.user;
      emit(IdleDashboard(user: user));
    } on ApiException catch (apiException) {
      emit(ErrorDashboard(apiException.toString()));
    } catch (e) {
      emit(ErrorDashboard(e.toString()));
    }
  }

}