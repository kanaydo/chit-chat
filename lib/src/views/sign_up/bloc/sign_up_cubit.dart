import 'package:flutter_base_app/src/core/app_exception.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/sign_up_response.dart';
import 'package:flutter_base_app/src/core/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {

  MemberRepository memberRepository = new MemberRepository();

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
        SignUpResponse response = await memberRepository.signUpMember(body);
        emit(SignUpSuccess(signUpResponse: response));
        emmitToIdle();
      } on ApiException catch(apiException) {
        emit(SignUpError(message: apiException.toString()));
        emmitToIdle();
      } catch (exception) {
        emit(SignUpFatalError(message: exception.toString()));
      }
    }
  }

  void emmitToIdle() {
    emit(SignUpIdle());
  }

  void resetForm() {
    emit(SignUpIdle());
  }

}