import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/dashboard_response.dart';
import 'package:flutter_base_app/src/utils/session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'member_state.dart';

class MemberCubit extends Cubit<MemberState>{

  SessionManager _sessionManager = SessionManager();
  MemberRepository memberRepository = MemberRepository();

  MemberCubit() : super(null) {
    _sessionManager.getActiveMember().then((value){
      if (value != 0) {
        fetchCurrentMemberProfile(value);
      }
    });

  }

  void fetchCurrentMemberProfile(int memberId) async {
    emit(LoadingMember(''));
    try {
      DashboardResponse response = await memberRepository.getMember(memberId);
      var member = response.member;
      if (member.id != null) {
        emit(IdleMember(member));
      }
    } on ApiException catch (apiException) {
      emit(ErrorMember(apiException.toString()));
    } catch (e) {
      emit(ErrorMember(e.toString()));
    }
  }
}