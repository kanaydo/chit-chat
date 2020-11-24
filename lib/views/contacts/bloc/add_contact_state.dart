/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 9:49 PM
 */

part of 'add_contact_cubit.dart';

@immutable
abstract class AddContactState {}

class AddContactIdle extends AddContactState {}

class AddContactError extends AddContactState {
  final String message;
  AddContactError({ this.message });
}

class AddContactContactFound extends AddContactState {
  final User user;
  AddContactContactFound({ this.user });
}