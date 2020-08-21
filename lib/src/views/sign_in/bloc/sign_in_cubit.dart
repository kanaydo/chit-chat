import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/sign_in_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {

  MemberRepository memberRepository = new MemberRepository();

  SignInCubit() : super(null){
    emit(SignInIdle());
  }

  void loginUser(String email, String password) async {
    if (email == "" || password == "") {
      emit(SignInError(message: "Harap isi semua form!"));
      emit(SignInIdle());
    }else {
      emit(SignInLoading(message: "Sedang memeriksa login anda, harap bersabar.."));
      Map<String, dynamic> body = {
        "credential": email.trim(),
        "password": password.trim()
      };
      try {
        SignInResponse loginResponse = await memberRepository.signInMember(body);
        if (loginResponse.result == true) {
          emit(SignInSuccess(member: loginResponse.member));
          emit(SignInIdle());
        } else {
          emit(SignInError(message: loginResponse.message));
          emit(SignInIdle());
        }
      } on ApiException catch (apiException){
        emit(SignInError(message: apiException.toString()));
        emit(SignInIdle());
      } catch (exception) {
        emit(SignInFatalError(message: exception.toString()));
      }
    }
  }

  void resetForm() {
    emit(SignInIdle());
  }

}