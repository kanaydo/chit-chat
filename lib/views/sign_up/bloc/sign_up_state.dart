part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpIdle extends SignUpState {
}

class SignUpLoading extends SignUpState {
  final String message;
  SignUpLoading({this.message});
}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;
  SignUpError({this.message});
}

class SignUpFatalError extends SignUpState {
  final String message;
  SignUpFatalError({this.message});
}