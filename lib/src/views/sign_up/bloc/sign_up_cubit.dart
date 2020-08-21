import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/sign_up_response.dart';
import 'package:flutter_base_app/src/utils/messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {

  MemberRepository memberRepository = new MemberRepository();

  SignUpCubit() : super(SignUpIdle());

  void signUpUser(String email, String phone, String password) async {
    if(email == "" || phone == "" || password == "") {
      emit(SignUpError(message: Messages.FILL_ALL_FIELD));
      emit(SignUpIdle());
    } else {
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
        "phone_number": phone,
      };
      Map<String, dynamic> body = {
        "member": data,
      };
      emit(SignUpLoading(message: Messages.SIGN_UP_LOADING));
      try {
        SignUpResponse response = await memberRepository.signUpMember(body);
        emit(SignUpSuccess(signUpResponse: response));
        emit(SignUpIdle());
      } on ApiException catch(apiException) {
        emit(SignUpError(message: apiException.toString()));
        emit(SignUpIdle());
      } catch (exception) {
        emit(SignUpFatalError(message: exception.toString()));
      }
    }
  }

  void resetForm() {
    emit(SignUpIdle());
  }

}