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