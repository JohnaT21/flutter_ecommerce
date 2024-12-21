import 'package:dio/dio.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/di/injector.dart';
import 'package:logger/logger.dart';

import '../models/error_responce.dart';
import '../models/shop_model.dart';

class ShopDataSource {
  final dioClient = sl.get<Dio>();
  final baseApiUrl = BASE_API_URL;

  Future<dynamic> getAllShops() async {
    try {
      final response = await dioClient.get("$baseApiUrl/shops");
      if (response.statusCode == 200) {
        return ShopResponse.fromJson(response.data);
      }
      //
      else if (response.statusCode == 401 || response.statusCode == 422) {
        return (ErrorResponce.fromJson(response.data));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
