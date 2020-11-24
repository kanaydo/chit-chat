/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 5:45 PM
 */

import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/core/session_manager.dart';
import 'package:flutter_base_app/data/model/contact.dart';
import 'package:flutter_base_app/data/repository/user_repository.dart';
import 'package:flutter_base_app/data/responses/contacts_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {

  var _sessionManager = SessionManager();
  var _userRepository = UserRepository();
  int _userId;

  ContactsCubit() : super(null) {
    _init();
  }

  void _init() async {
    int userId = await _sessionManager.getActiveMember();
    if (userId != null || userId != 0) {
      this._userId = userId;
      _fetchUserContacts();
    }
  }

  void _fetchUserContacts() async {
    emit(ContactsLoading(message: 'getting user contacts'));
    try {
      ContactsResponse contactsResponse = await _userRepository.getUserContacts(_userId);
      emit(ContactsIdle(contacts: contactsResponse.contacts));
    } on ApiException catch (api) {
      emit(ContactsError(message: api.toString()));
    } catch (e) {
      emit(ContactsFatalError(message: e.toString()));
    }
  }

}