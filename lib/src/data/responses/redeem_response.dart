import 'package:flutter_base_app/src/data/model/redeem.dart';

class RedeemResponse {
  Redeem _redeem;

  RedeemResponse.fromJSON(json) {
    _redeem = new Redeem.fromJSON(json['redeem']);
  }

  Redeem get redeem => _redeem;
}