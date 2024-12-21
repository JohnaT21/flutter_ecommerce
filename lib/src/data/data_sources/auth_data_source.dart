import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/core/Api/custom_exception.dart';
import 'package:ecommerce/src/core/Api/response_status.dart';
import 'package:logger/logger.dart';

import '../../config/env.dart';
import '../../di/injector.dart';
import '../models/error_responce.dart';
import '../models/user_model.dart';
import '../models/user_response_model.dart';

class AuthDataSource {
  final dioClient = sl.get<Dio>();
  final baseApiUrl = BASE_API_URL;

  @override
  Future<dynamic> login(
      {required String email, required String password}) async {
    Logger().d(email, password);
    var mm = {"input": email, "password": password};
    try {
      final response = await dioClient.post(
        "$baseApiUrl/auth/login",
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode(mm),
      );
      Logger().d(response.data);
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      }
      //
      else if (response.statusCode == 401 || response.statusCode == 422) {
        return (ErrorResponce.fromJson(response.data));
      }
    }

    //
    catch (e) {
      print(e);
      throw Exception(e);
    }
    return "Error occurred";
  }

  @override
  Future<UserResponse> register({required UserModel userInfo}) async {
    Logger().d(userInfo.toJson());
    UserResponse responseJson;
    try {
      final response = await dioClient.post(
        "$BASE_API_URL/auth/register",
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: userInfo.toJson(),
      );
      Logger().d(response);
      responseJson =
          userResponseFromJson(json.encode(ResponseStatus(response)));
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on DioError catch (e) {
      Logger().i(e);
      throw FetchDataException(message: 'Something went wrong!');
    }

    return responseJson;
  }

  // reset password
  @override
  Future<String> requestEmailPasswordReset({required String email}) async {
    try {
      final response = await dioClient.patch(
        "$baseApiUrl/auth/forgetPassword",
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: json.encode({"email": email}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return "Reset Email sent";
      }
      //
      else if (response.statusCode == 400) {
        return (response.data['error']['message'].toString());
      }
    }

    //
    catch (e) {
      print(e);
    }
    return "Error occurred";
  }

  @override
  Future<String> changePassword(
      {required String userId,
      required String oldPassword,
      required String newPassword}) async {
    try {
      final response = await dioClient.post(
        "$baseApiUrl/users/changePassword",
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: json.encode({
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        }),
      );

      print(response);

      // if (response.statusCode == 201 || response.statusCode == 200) {
      //   return "Successfully Registered";
      // }
      // //
      // else if (response.statusCode == 400) {
      //   return (response.data['error']['message'].toString());
      // }
    }

    //
    catch (e) {
      print(e);
    }
    return "Error occurred";
  }

  Future<dynamic> googleSignIn(String token) async {
    print(token);
    try {
      final response = await dioClient.get(
        "https://api.liyumarket.com/api/socials/google?access_token=$token",
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        Logger().d(response);
        return UserResponse.fromJson(response.data);
      }
      //
      else if (response.statusCode == 401 || response.statusCode == 422) {
        return (ErrorResponce.fromJson(response.data));
      }
    }

    //
    catch (e) {
      print(e);
      throw Exception(e);
    }
    return "Error occurred";
  }
}
