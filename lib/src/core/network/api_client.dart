import 'package:dio/dio.dart';
import 'package:flutter_base_app/src/utils/const.dart';

abstract class ApiClient {

  var _dio = new Dio();

  ApiClient() {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Token $ACCESS_TOKEN";
    _dio.options.baseUrl = API_ROOT;
    _dio.options.connectTimeout = 10*1000;
  }

  Dio get dio => _dio;

}