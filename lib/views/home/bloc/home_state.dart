part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class CheckAuthenticate extends HomeState {
  final String message;
  CheckAuthenticate({this.message});
}

class Authenticated extends HomeState {}

class UnAuthenticated extends HomeState {}
