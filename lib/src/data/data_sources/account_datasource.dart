import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/core/Api/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

import '../../core/Api/response_status.dart';

abstract class AccountRemoteDataSource {
  Future<Map<String, dynamic>> getAccount();
  Future<dynamic> updateAccount(Map<String, String> userModel, String? ppImage);
  Future<dynamic> updateDeviceToken({required String deviceToken});
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final Dio client;
  final baseApiUrl = BASE_API_URL;

  AccountRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> getAccount() async {
    var responseJson;
    try {
      final response = await client.get(
        '$baseApiUrl/users/$USERID',
        options: Options(
          headers: {
            'Authorization': 'Bearer $TOKEN',
          },
        ),
      );
      responseJson = ResponseStatus(response);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on DioError catch (e) {
      Logger().d(e.response!.data);
      throw FetchDataException(message: e.response!.data["error"]["message"]);
    }
    return responseJson;
  }

  @override
  Future updateAccount(Map<String, String> userModel, String? ppImage) async {
    String responseJson;
    Logger().d(jsonEncode(userModel));
    var headers = {
      Headers.contentTypeHeader: "application/json",
      'Authorization': 'Bearer $TOKEN',
    };
    try {
      var request =
          http.MultipartRequest('PATCH', Uri.parse('$baseApiUrl/users'));
      request.fields.addAll(userModel);
      ppImage != null
          ? request.files.add(await http.MultipartFile.fromPath(
              'image', ppImage,
              contentType: MediaType('image', 'jpg')))
          : null;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        responseJson = await response.stream.bytesToString();
      } else {
        Logger().d("Error Occured!");
        throw FetchDataException(message: "error occure");
      }
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on DioError catch (e) {
      Logger().d(e.response!.data);
      // throw FetchDataException(message: e.response!.data["error"]["message"]);
      throw FetchDataException(message: e.response!.data["error"]["message"]);
    }
    return responseJson;
  }

  @override
  Future updateDeviceToken({required String deviceToken}) async {
    String responseJson;
    Logger().d(jsonEncode(deviceToken));
    try {
      final response = await client.post(
        '$baseApiUrl/users/$USERID',
        options: Options(
          headers: {'Authorization': 'Bearer $TOKEN'},
        ),
        data: {"device_token": deviceToken},
      );
      responseJson = ResponseStatus(response).toString();
      Logger().d(responseJson);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on DioError catch (e) {
      Logger().d(e);
      throw FetchDataException(
          message:
              e.response!.data['error']['message'] ?? 'No Internet connection');
    }
    return responseJson;
  }
}
