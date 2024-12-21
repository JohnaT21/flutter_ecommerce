// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:dio/dio.dart' as di;
import 'package:ecommerce/src/config/local_storage.dart';
import 'package:ecommerce/src/data/models/error_responce.dart';
import 'package:logger/logger.dart';

import 'custom_exception.dart';

dynamic ResponseStatus(di.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = response.data;
      return responseJson;
    case 201:
      var responseJson = response.data;
      Logger().d(responseJson);
      return responseJson;
    case 204:
      var responseJson = response.data;
      return responseJson;
    case 400:
      if (response is di.DioError) {
        di.DioError res = response as di.DioError;
        Logger().d(res.response!.data);
        throw BadRequestException(
            ErrorResponce.fromJson(json.decode(res.response!.data))
                .error
                .message);
      }
      break;
    case 401:
      Storage.clearStorage();
      Logger().d(response.data);
      throw UnauthorisedException(json.decode(response.data.toString()));
    case 403:
      throw UnauthorisedException(json.decode(response.data.toString()));
    case 500:
    default:
      throw FetchDataException(
          message:
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
