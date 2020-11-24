/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class CheckAuthenticate extends HomeState {
  final String message;
  CheckAuthenticate({this.message});
}

class Authenticated extends HomeState {}

class UnAuthenticated extends HomeState {}
