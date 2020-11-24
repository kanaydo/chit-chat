/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/20/20, 2:57 PM
 */

part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileIdle extends UserProfileState {
  final User user;
  UserProfileIdle({ this.user });
}

class UserProfileLoading extends UserProfileState {
  final String message;
  UserProfileLoading({ this.message });
}

class UserProfileError extends UserProfileState {
  final String message;
  UserProfileError({ this.message });
}

