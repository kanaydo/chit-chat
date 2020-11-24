/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 5:45 PM
 */

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