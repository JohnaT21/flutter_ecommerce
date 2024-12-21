import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/data/models/error_responce.dart';
import 'package:ecommerce/src/data/models/notification_response_model.dart';

import '../../di/injector.dart';

class NotificationDataSource {
  final dioClient = sl.get<Dio>();
  final baseApiUrl = BASE_API_URL;

  @override
  Future getNotifications() async {
    try {
      final response = await dioClient.get(
        "$baseApiUrl/notifications",
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return NotificationResponse.fromJson(response.data);
      }
      //
      else if (response.statusCode == 401 || response.statusCode == 422) {
        return (ErrorResponce.fromJson(response.data));
      }
    }

    //
    catch (e) {
      throw Exception(e);
    }
    return "Error occurred";
  }
}