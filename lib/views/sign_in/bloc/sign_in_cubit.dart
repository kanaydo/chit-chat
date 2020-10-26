import 'package:flutter_base_app/core/const/strings.dart';
import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/repository/member_repository.dart';
import 'package:flutter_base_app/data/responses/sign_in_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {

  var memberRepository = MemberRepository();
  var sessionManager = SessionManager();

  SignInCubit() : super(null){
    emit(SignInIdle());
  }

  void loginUser(String email, String password) async {
    if (email == "" || password == "") {
      emit(SignInError(message: Strings.MESSAGE_FILL_ALL_FIELD));
      emit(SignInIdle());
    }else {
      emit(SignInLoading(message: Strings.LOADING_LOGIN_CHECK));
      Map<String, dynamic> body = {
        "credential": email.trim(),
        "password": password.trim()
      };
      try {
        SignInResponse loginResponse = await memberRepository.signInUser(body);
        validateSignIn(loginResponse);
      } on ApiException catch (apiException){
        emit(SignInError(message: apiException.toString()));
        emit(SignInIdle());
      } catch (exception) {
        emit(SignInFatalError(message: exception.toString()));
      }
    }
  }

  void validateSignIn(SignInResponse signInResponse) {
    if (signInResponse.user != null) {
      var member = signInResponse.user;
      sessionManager.setActiveMember(member);
      emit(SignInSuccess());
      emit(SignInIdle());
    } else {
      emit(SignInError(message: Strings.MESSAGE_UNKNOWN_ERROR));
      emit(SignInIdle());
    }
  }

  void resetForm() {
    emit(SignInIdle());
  }

}