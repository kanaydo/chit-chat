import 'package:dio/dio.dart';
import 'package:flutter_base_app/src/core/api_client.dart';
import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/city.dart';
import 'package:flutter_base_app/src/data/model/district.dart';
import 'package:flutter_base_app/src/data/model/province.dart';
import 'package:flutter_base_app/src/data/model/village.dart';

class ProvinceRepository extends ApiClient {
  getProvinceList() async {
    try {
      var response = await dio.get('provinces');
      final provinces = List<Province>.of(
        response.data.map<Province>((json) =>
            Province.fromJSON(json),
        ),
      );
      return provinces;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.toString());
      }
    }
  }

  getProvinceCities(int province) async {
    try {
      var response = await dio.get('cities?province_id=$province');
      final cities = List<City>.of(
        response.data.map<City>((json) =>
            City.fromJSON(json),
        ),
      );
      return cities;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.toString());
      }
    }
  }

  getDistrictsByCity(int city) async {
    try {
      var response = await dio.get('districts?city_id=$city');
      final districts = List<District>.of(
        response.data.map<District>((json) =>
            District.fromJSON(json),
        ),
      );
      return districts;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.toString());
      }
    }
  }


  getVillageByDistrict(int district) async {
    try {
      var response = await dio.get('villages?district_id=$district');
      final villages = List<Village>.of(
        response.data.map<Village>((json) =>
            Village.fromJSON(json),
        ),
      );
      return villages;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.toString());
      }
    }
  }

}