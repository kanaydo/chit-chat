import 'package:dio/dio.dart';
import 'package:flutter_base_app/src/core/api_client.dart';
import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/responses/banners_response.dart';

class BannerRepository extends ApiClient {

  getBanners() async {
    try {
      var response = await dio.get('banners');
      BannersResponse bannersResponse = BannersResponse.fromJson(response.data['banners']);
      return bannersResponse;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.message);
      }
    }
  }

}