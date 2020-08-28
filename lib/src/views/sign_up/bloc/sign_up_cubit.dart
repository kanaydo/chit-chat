import 'package:flutter_base_app/src/core/network/app_exception.dart';
import 'package:flutter_base_app/src/core/session_manager.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/sign_up_response.dart';
import 'package:flutter_base_app/src/core/const/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {

  MemberRepository memberRepository = MemberRepository();
  SessionManager sessionManager = SessionManager();

  SignUpCubit() : super(SignUpIdle());

  Map<String, dynamic> buildUserParams(String email, String password) {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };
    return {
      "member": data,
    };
  }

  void signUpUser(String email, String password) async {
    if(email == "" || password == "") {
      emit(SignUpError(message: Strings.MESSAGE_FILL_ALL_FIELD));
      emmitToIdle();
    } else {
      var body = buildUserParams(email, password);
      emit(SignUpLoading(message: Strings.LOADING_SIGN_UP));
      try {
        SignUpResponse response = await memberRepository.signUpUser(body);
        validateSignUp(response);
      } on ApiException catch(apiException) {
        emit(SignUpError(message: apiException.toString()));
        emmitToIdle();
      } catch (exception) {
        emit(SignUpFatalError(message: exception.toString()));
      }
    }
  }

  void validateSignUp(SignUpResponse signUpResponse) {
    if (signUpResponse.user != null) {
      var member = signUpResponse.user;
      sessionManager.setActiveMember(member);
      emit(SignUpSuccess());
      emmitToIdle();
    } else {
      emit(SignUpError(message: Strings.MESSAGE_UNKNOWN_ERROR));
      emmitToIdle();
    }
  }

  void emmitToIdle() {
    emit(SignUpIdle());
  }

  void resetForm() {
    emit(SignUpIdle());
  }

}