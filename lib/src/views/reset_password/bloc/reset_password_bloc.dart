import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {

  MemberRepository memberRepository = MemberRepository();

  ResetPasswordCubit() : super(null) {
    emit(ResetPasswordIdle());
  }

  void resetMemberPassword(String email) async {
    if (email == "") {
      emit(ResetPasswordError(message: "Mohon isi email anda!"));
      emit(ResetPasswordIdle());
    } else {
      try {
        var response = await memberRepository.resetPassword(email.trim());
        emit(ResetPasswordSuccess(message: response));
      } on ApiException catch (apiException) {
        emit(ResetPasswordError(message: apiException.toString()));
        emit(ResetPasswordIdle());
      } catch (e) {
        emit(ResetPasswordError(message: e.toString()));
        emit(ResetPasswordIdle());
      }
    }

  }

}