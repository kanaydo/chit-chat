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

