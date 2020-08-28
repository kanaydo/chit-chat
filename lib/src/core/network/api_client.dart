import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiClient {

  var _dio = new Dio();

  ApiClient() {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = 'Token ${DotEnv().env['ACCESS_TOKEN']}';
    _dio.options.baseUrl = '${DotEnv().env['API_ROOT']}';
    _dio.options.connectTimeout = 10*1000;
  }

  Dio get dio => _dio;

}