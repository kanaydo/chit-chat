part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState {}

class ContactsIdle extends ContactsState {
  final List<Contact> contacts;
  ContactsIdle({ this.contacts });
}

class ContactsLoading extends ContactsState {
  final String message;
  ContactsLoading({ this.message });
}

class ContactsError extends ContactsState {
  final String message;
  ContactsError({ this.message });
}

class ContactsFatalError extends ContactsState {
  final String message;
  ContactsFatalError({ this.message });
}