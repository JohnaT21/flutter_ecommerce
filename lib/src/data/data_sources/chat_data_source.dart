import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/core/Api/custom_exception.dart';
import 'package:logger/logger.dart';

import '../../core/Api/response_status.dart';

abstract class ChatRemoteDataSource {
  Future<Map<String, dynamic>> getChatLists();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio client;
  final baseApiUrl = BASE_API_URL;

  ChatRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> getChatLists() async {
    var responseJson;
    try {
      final response = await client.get(
        '$baseApiUrl/chat/list',
        options: Options(
          headers: {
            'Authorization': 'Bearer $TOKEN',
          },
        ),
      );
      Logger().d(response);
      responseJson = ResponseStatus(response);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on DioError catch (e) {
      Logger().d(e.response!.data);
      throw FetchDataException(message: e.response!.data["error"]["message"]);
    }
    return responseJson;
  }
}
