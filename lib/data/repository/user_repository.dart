import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_base_app/core/network/api_client.dart';
import 'package:flutter_base_app/core/network/app_exception.dart';
import 'package:flutter_base_app/data/responses/contacts_response.dart';
import 'package:flutter_base_app/data/responses/profile_response.dart';
import 'package:flutter_base_app/data/responses/sign_in_response.dart';
import 'package:flutter_base_app/data/responses/sign_up_response.dart';
import 'package:flutter_base_app/data/responses/user_profile_response.dart';

class UserRepository extends ApiClient {
  signInUser(Map<String, dynamic> params) async {
    try {
      var response = await dio.post('user_sessions', data: json.encode(params));
      var loginResponse = SignInResponse.fromJSON(response.data);
      return loginResponse;
    } on DioError catch (e) {
      if (e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else {
        print(e.toString());
        throw Exception(e.toString());
      }
    }
  }

  getUser(int userId) async {
    try {
      var response = await dio.get('users/$userId');
      UserProfileResponse userProfileResponse =
          UserProfileResponse.fromJSON(response.data);
      return userProfileResponse;
    } on DioError catch (e) {
      if (e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else {
        throw Exception(e.type);
      }
    }
  }

  getUserContacts(int userId) async {
    try {
      var response = await dio.get('users/$userId/contacts');
      ContactsResponse contactsResponse =
          ContactsResponse.fromJSON(response.data);
      return contactsResponse;
    } on DioError catch (e) {
      if (e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else {
        throw Exception(e.type);
      }
    }
  }

  getUserProfile(int memberId) async {
    try {
      var response = await dio.get('users/$memberId/profile');
      var profileResponse = ProfileResponse.fromJSON(response.data);
      return profileResponse;
    } on DioError catch (e) {
      if (e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else {
        throw Exception(e.toString());
      }
    }
  }

  signUpUser(Map<String, dynamic> params) async {
    try {
      var response = await dio.post('members', data: json.encode(params));
      var signUpResponse = SignUpResponse.fromJSON(response.data);
      return signUpResponse;
    } on DioError catch (e) {
      if (e.response != null) {
        var message = e.response.data['message'];
        throw ApiException(message: message);
      } else {
        throw Exception(e.toString());
      }
    }
  }

  updateUserProfile(Map<String, dynamic> params, int memberId) async {
    try {
      var response =
          await dio.patch('members/$memberId', data: json.encode(params));
      ProfileResponse profileResponse = ProfileResponse.fromJSON(response.data);
      return profileResponse;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response != null) {
          var message = e.response.data['message'];
          throw ApiException(message: message);
        } else {
          throw Exception(e.toString());
        }
      }
    }
  }
}
