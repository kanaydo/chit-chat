/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/20/20, 3:07 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/data/repository/user_repository.dart';
import 'package:flutter_base_app/data/responses/user_profile_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {

  var sessionManager = SessionManager();
  var userRepository = UserRepository();

  UserProfileCubit() : super(null) {
    fetchUserProfile();
  }

  fetchUserProfile() async {
    int userId = await sessionManager.getActiveMember();
    emit(UserProfileLoading(message: 'getting user'));
    try {
      UserProfileResponse userProfileResponse = await userRepository.getUser(userId);
      emit(UserProfileIdle(user: userProfileResponse.user));
    } on ApiException catch (api) {
      emit(UserProfileError(message: api.toString()));
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }
  }

}

