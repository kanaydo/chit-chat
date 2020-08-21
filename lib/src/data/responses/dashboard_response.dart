import 'package:flutter_base_app/src/data/model/member.dart';

class DashboardResponse {
  Member _member;
  DashboardResponse.fromJSON(json) {
    _member = new Member.fromJSON(json['member']);
  }
  Member get member => _member;
}