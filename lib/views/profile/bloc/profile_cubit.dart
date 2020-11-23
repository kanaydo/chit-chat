import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/data/responses/user_profile_response.dart';
import 'package:meta/meta.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  var _sessionManager = SessionManager();
  var _userRepository = UserRepository();
  int _userId;

  ProfileCubit() : super(null) {
    _init();
  }

  void _init() async {
    int userId = await _sessionManager.getActiveMember();
    if (userId != 0 || userId != null) {
      this._userId = userId;
      fetchUserProfile();
    }
  }

  void fetchUserProfile() async {
    emit(ProfileLoading(message: 'getting user profile'));
    try {
      UserProfileResponse userProfileResponse =
          await _userRepository.getUser(_userId);
      emit(ProfileIdle(user: userProfileResponse.user));
    } on ApiException catch (api) {
      emit(ProfileError(message: api.message));
    } catch (e) {
      emit(ProfileFatalError(message: e.toString()));
    }
  }

  void signOutUser() async {
    bool status = await _sessionManager.signOutUser();
    if (status == true) {
      emit(ProfileSuccessSignOut());
    } else {
      emit(ProfileError(message: 'Something wrong, please try again! '));
    }
  }

}
