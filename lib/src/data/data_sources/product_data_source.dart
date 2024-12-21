import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/data/models/product_by_category_model.dart';
import 'package:ecommerce/src/data/models/products_response_model.dart';
import 'package:ecommerce/src/domain/entities/product_category.dart';
import 'package:logger/logger.dart';

import '../../config/env.dart';
import '../../core/Api/custom_exception.dart';
import '../../core/Api/response_status.dart';
import '../../di/injector.dart';
import '../models/error_responce.dart';

class ProductDataSource {
  final dioClient = sl.get<Dio>();
  final baseApiUrl = BASE_API_URL;

  Future<ProductsResponse> getProducts() async {
    var responseJson;
    try {
      final response = await dioClient.get(
        "$baseApiUrl/products",
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      final res = json.encode(ResponseStatus(response));
      responseJson = productsResponseFromJson(res);
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

  Future<ProductCategory> getProductCategory() async {
    var responseJson;
    try {
      final response = await dioClient.get(
        "$baseApiUrl/categories",
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      responseJson = ResponseStatus(response);
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    }
    return responseJson;
  }

  Future<ProductByCategoryModel> getProductsBySubcategory(
      String subCategoryId) async {
    try {
      final response = await dioClient.get(
        "$baseApiUrl/subcategories/$subCategoryId",
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      final products = ResponseStatus(response);

      return productByCategoryModelFromJson(jsonEncode(products));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ProductsResponse> searchProducts({required String query}) async {
    try {
      final response = await dioClient.get(
        "$baseApiUrl/products?search=$query&featured=true&premium=true&state=ACTIVE",
        options: Options(
          followRedirects: false,
          receiveTimeout: 100000,
          sendTimeout: 100000,
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final products = response.data;
        return ProductsResponse.fromJson(products);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<ProductsResponse> filterProductsById(
      {required String sellerId}) async {
    try {
      final response = await dioClient.get(
        '$baseApiUrl/products?filters=[{"seller":"$sellerId"}]',
        options: Options(
          followRedirects: false,
          receiveTimeout: 100000,
          sendTimeout: 100000,
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final products = response.data;
        return ProductsResponse.fromJson(products);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future getRelatedProducts(String productId) async {
    try {
      final response = await dioClient.get(
        "$baseApiUrl/products/$productId",
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductsResponse.fromJson(response.data);
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
