import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/login_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  MemberRepository memberRepository = new MemberRepository();

  LoginCubit() : super(null){
    emit(LoginIdle());
  }

  void loginUser(String email, String password) async {
    if (email == "" || password == "") {
      emit(LoginError(message: "Harap isi semua form!"));
      emit(LoginIdle());
    }else {
      emit(LoginLoading(message: "Sedang memeriksa login anda, harap bersabar.."));
      Map<String, dynamic> body = {
        "credential": email.trim(),
        "password": password.trim()
      };
      try {
        LoginResponse loginResponse = await memberRepository.signInMember(body);
        if (loginResponse.result == true) {
          emit(LoginSuccess(member: loginResponse.member));
          emit(LoginIdle());
        } else {
          emit(LoginError(message: loginResponse.message));
          emit(LoginIdle());
        }
      } on ApiException catch (apiException){
        emit(LoginError(message: apiException.toString()));
        emit(LoginIdle());
      } catch (exception) {
        emit(LoginFatalError(message: exception.toString()));
      }
    }
  }

  void resetForm() {
    emit(LoginIdle());
  }

}