import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_base_app/src/core/api_client.dart';
import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/responses/redeem_response.dart';

class RedeemRepository extends ApiClient {
  redeemReward(Map<String, dynamic> params) async {
    try {
      var response = await dio.post('redeems', data: json.encode(params));
      RedeemResponse redeemResponse = RedeemResponse.fromJSON(response.data);
      return redeemResponse;
    } on DioError catch(e) {
      if (e.response != null) {
        if(e.response != null) {
          var message = e.response.data['message'];
          throw ApiException(message: message);
        } else{
          throw Exception(e.toString());
        }
      }
    }
  }
}