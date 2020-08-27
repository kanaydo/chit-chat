import 'package:dio/dio.dart';
import 'package:flutter_base_app/src/core/network/api_client.dart';
import 'package:flutter_base_app/src/core/network/app_exception.dart';
import 'package:flutter_base_app/src/data/responses/rewards_response.dart';

class RewardRepository extends ApiClient {

  getRewardList() async {
    try {
      var response = await dio.get('rewards');
      RewardsResponse rewardsResponse = RewardsResponse.fromJson(response.data['rewards']);
      return rewardsResponse;
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