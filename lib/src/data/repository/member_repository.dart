import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_base_app/src/core/network/app_exception.dart';
import 'package:flutter_base_app/src/core/network/api_client.dart';
import 'package:flutter_base_app/src/data/responses/member_responses.dart';

class MemberRepository extends ApiClient {

  signInMember(Map<String, dynamic> params) async {
    try {
      var response = await dio.post('authentications', data: json.encode(params));
      SignInResponse loginResponse = SignInResponse.fromJSON(response.data);
      return loginResponse;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.toString());
      }
    }
  }

  getMember(int memberId) async {
    try {
      var response = await dio.get('members/$memberId');
      DashboardResponse dashboardResponse = DashboardResponse.fromJSON(response.data);
      return dashboardResponse;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.type);
      }
    }
  }

  resetPassword(String email) async {
    try {
      var response = await dio.get('members/reset_password?email=$email');
      return response.data['message'];
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.toString());
      }
    }
  }

  getMemberProfile(int memberId) async {
    try {
      var response = await dio.get('members/$memberId/profile');
      ProfileResponse profileResponse = ProfileResponse.fromJSON(response.data);
      return profileResponse;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.toString());
      }
    }
  }

  signUpMember(Map<String, dynamic> params) async {
    try {
      var response = await dio.post('members', data: json.encode(params));
      SignUpResponse signUpResponse = SignUpResponse.fromJSON(response.data);
      return signUpResponse;
    } on DioError catch(e) {
      if(e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else{
        throw Exception(e.toString());
      }
    }
  }

  updateMemberProfile(Map<String, dynamic> params, int memberId) async {
    try {
      var response = await dio.patch('members/$memberId', data: json.encode(params));
      ProfileResponse profileResponse = ProfileResponse.fromJSON(response.data);
      return profileResponse;
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