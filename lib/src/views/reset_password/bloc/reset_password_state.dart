part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordIdle extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final String message;
  ResetPasswordSuccess({this.message});
}

class ResetPasswordLoading extends ResetPasswordState {
  final String message;
  ResetPasswordLoading({this.message});
}

class ResetPasswordError extends ResetPasswordState {
  final String message;
  ResetPasswordError({this.message});
}