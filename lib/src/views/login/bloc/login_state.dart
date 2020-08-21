part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginIdle extends LoginState {}

class LoginLoading extends LoginState {
  final String message;
  LoginLoading({this.message});
}

class LoginSuccess extends LoginState {
  final Member member;
  LoginSuccess({this.member});
}

class LoginError extends LoginState {
  final String message;
  LoginError({this.message});
}

class LoginFatalError extends LoginState {
  final String message;
  LoginFatalError({this.message});
}