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