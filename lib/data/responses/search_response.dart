import 'package:flutter_base_app/data/model/user.dart';

class SearchResponse {
  User _user;
  SearchResponse.fromJSON(response) {
    _user = User.fromJSON(response['user']);
  }
  User get user => _user;
}