import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/data/models/product_detail_model.dart';
import 'package:logger/logger.dart';

import '../../config/env.dart';
import '../../core/Api/custom_exception.dart';
import '../../core/Api/response_status.dart';

abstract class ProductDetailRemoteDataSource {
  Future<ProductDetailResponse> getProductDetail(String productId);
}

class ProductDetailRemoteDataSourceImpl
    implements ProductDetailRemoteDataSource {
  final Dio client;
  final baseApiUrl = BASE_API_URL;

  ProductDetailRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductDetailResponse> getProductDetail(String productId) async {
    ProductDetailResponse responseJson;

    try {
      final response = await client.get(
        '$baseApiUrl/products/$productId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $TOKEN',
          },
        ),
      );

      responseJson =
          productDetailResponseFromJson(json.encode(ResponseStatus(response)));
    } on SocketException catch (e) {
      Logger().d(e);
      throw FetchDataException(message: 'No Internet connection');
    } on DioError catch (e) {
      Logger().d(e);
      throw FetchDataException(message: 'No Internet connection');
    }

    return responseJson;
  }
}
