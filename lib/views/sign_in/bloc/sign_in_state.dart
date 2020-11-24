/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInIdle extends SignInState {}

class SignInLoading extends SignInState {
  final String message;
  SignInLoading({this.message});
}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String message;
  SignInError({this.message});
}

class SignInFatalError extends SignInState {
  final String message;
  SignInFatalError({this.message});
}