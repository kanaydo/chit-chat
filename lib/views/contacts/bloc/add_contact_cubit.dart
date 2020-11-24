/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 10:42 PM
 */

import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/data/model/user.dart';
import 'package:flutter_base_app/data/repository/user_repository.dart';
import 'package:flutter_base_app/data/responses/search_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactState> {
  var _userRepository = UserRepository();

  AddContactCubit() : super(null) {
    _init();
  }

  void _init() {
    emit(AddContactIdle());
  }

  void scanData(String username) async {
    try {
      SearchResponse response = await _userRepository.searchUser(username);
      if (response != null) {
        emit(AddContactContactFound(user: response.user));
      } else {
        emit(AddContactError(message: 'try again'));
        emit(AddContactIdle());
      }
    } on ApiException catch (api) {
      emit(AddContactError(message: api.message));
      emit(AddContactIdle());
    } catch (e) {
      emit(AddContactError(message: e.toString()));
      emit(AddContactIdle());
    }

  }

}