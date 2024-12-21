import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/core/Api/CustomException.dart';
import 'package:ecommerce/src/core/Api/response_status.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../../config/env.dart';
import '../../di/injector.dart';
import '../models/error_responce.dart';
import '../models/favorite_model.dart';

class FavoriteDataSource {
  final dioClient = sl.get<Dio>();
  final baseApiUrl = BASE_API_URL;

  Future<FavoriteResponse> getFavorites() async {
    FavoriteResponse responseJson;
    try {
      final response = await dioClient.get(
        "$baseApiUrl/favorites",
        options: Options(
            followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $TOKEN",
            }),
      );
      responseJson =
          favoriteResponseFromJson(json.encode(ResponseStatus(response)));
      Logger().d(responseJson);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on DioError catch (e) {
      Logger().d(e.response!.data);
      throw FetchDataException(
          message:
              e.response!.data['error']['message'] ?? 'No Internet connection');
    }
    return responseJson;
  }

  addToFavorite({required String product}) async {
    try {
      print(USERID);
      print(product);
      print(TOKEN);
      final response = await dioClient.post(
        "$baseApiUrl/favorites",
        options: Options(
            followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $TOKEN",
            }),
        data: {"product": product},
      );
      print(response);
      if (response.statusCode == 200) {
        print(response.data);
        return "data added";
      }
      //
      else if (response.statusCode == 401 || response.statusCode == 422) {
        return "data add error";
      }
    }

    //
    catch (e) {
      print(e);
      throw Exception(e);
    }
    return "Error occurred";
  }

  removeFromFavorite({required String product}) {}
}
