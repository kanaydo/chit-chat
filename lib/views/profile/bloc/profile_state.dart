/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/23/20, 11:30 PM
 */

part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileIdle extends ProfileState {
  final User user;
  ProfileIdle({this.user});
}

class ProfileLoading extends ProfileState {
  final String message;
  ProfileLoading({this.message});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({this.message});
}

class ProfileFatalError extends ProfileState {
  final String message;
  ProfileFatalError({this.message});
}

class ProfileSuccessSignOut extends ProfileState {}