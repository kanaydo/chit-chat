import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/profile_response.dart';
import 'package:flutter_base_app/src/utils/messages.dart';
import 'package:flutter_base_app/src/utils/session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  SessionManager _sessionManager = SessionManager();
  MemberRepository _memberRepository = MemberRepository();
  Member member;

  ProfileCubit() : super(null) {
    _sessionManager.getActiveMember().then((value){
      if (value != 0) {
        fetchCurrentMemberProfile(value);
      }
    });
  }

  void refreshProfile() {
    _sessionManager.getActiveMember().then((value){
      if (value != 0) {
        fetchCurrentMemberProfile(value);
      }
    });
  }

  void fetchCurrentMemberProfile(int memberId) async {
    emit(ProfileLoading(message: Messages.FETCH_PROFILE_LOADING));
    try {
      ProfileResponse response = await _memberRepository.getMemberProfile(memberId);
      this.member = response.member;
      emit(ProfileIdle(member: member));
    } on ApiException catch (apiException) {
      emit(ProfileError(message: apiException.toString()));
    } catch (e) {
      emit(ProfileFatalError(message: e.toString()));
    }
  }

  logoutCurrentMember() async {
    bool result = await _sessionManager.logoutMember();
    if (result == true) {
      emit(LogoutSuccessState());
    }
  }
}