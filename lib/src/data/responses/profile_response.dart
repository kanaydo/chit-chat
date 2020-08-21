import 'package:flutter_base_app/src/data/model/member.dart';

class ProfileResponse {
  Member _member;

  ProfileResponse.fromJSON(json) {
    _member = new Member.fromJSON(json['member']);
  }

  Member get member => _member;
}