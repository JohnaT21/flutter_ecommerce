import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/data/models/regions_model.dart';
import 'package:ecommerce/src/domain/entities/add_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../config/env.dart';
import '../../core/Api/custom_exception.dart';
import '../../core/Api/response_status.dart';
import '../../domain/entities/product_category.dart';

abstract class SellRemoteDataSource {
  Future<ProductCategory> getProductCategory();
  Future<RegionModel> getRegions();
  Future<String> addProduct({required AddProductModel addProductModel});
  Future<dynamic> addProductImage(
      {required List<XFile>? formdata, required String pId});
}

class SellRemoteDataSourceImpl implements SellRemoteDataSource {
  final Dio client;
  final baseApiUrl = BASE_API_URL;

  SellRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductCategory> getProductCategory() async {
    ProductCategory responseJson;

    try {
      final response = await client.get(
        '$baseApiUrl/categories',
        options: Options(
          headers: {
            'Authorization': 'Bearer $TOKEN',
          },
        ),
      );

      responseJson =
          productCategoryFromJson(json.encode(ResponseStatus(response)));
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on DioError {
      throw FetchDataException(message: 'No Internet connection');
    }

    return responseJson;
  }

  @override
  Future<String> addProduct({required AddProductModel addProductModel}) async {
    Logger().d(addProductModel);
    var responseJson;

    try {
      final response = await client.post(
        '$baseApiUrl/products',
        options: Options(
          headers: {'Authorization': 'Bearer $TOKEN'},
        ),
        data: jsonEncode(addProductModel),
      );
      responseJson =
          jsonDecode(json.encode(ResponseStatus(response)))["data"]["id"];
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

  @override
  Future<dynamic> addProductImage(
      {required List<XFile>? formdata, required String pId}) async {
    String responseJson = '';
    try {
      var headers = {'Authorization': 'Bearer $TOKEN'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseApiUrl/products/uploadImages/$pId'));
      for (var element in formdata!) {
        request.files.add(await http.MultipartFile.fromPath(
            'images', element.path,
            filename: element.name, contentType: MediaType('image', 'jpg')));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      Logger().d(response.stream);
      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = await response.stream.bytesToString();
        Logger().d(responseJson);
      } else {
        Logger().d("Error Occured!");
        throw FetchDataException(message: "error occure in product add");
      }
    } catch (e) {
      Logger().d(e);
    }

    return responseJson;
  }

  @override
  Future<RegionModel> getRegions() async {
    RegionModel responseJson;

    try {
      final response = await client.get(
        '$baseApiUrl/regions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $TOKEN',
          },
        ),
      );

      Logger().d(response);
      responseJson = regionModelFromJson(json.encode(ResponseStatus(response)));
    } on SocketException {
      throw FetchDataException(message: 'No Internet connection');
    } on DioError {
      throw FetchDataException(message: 'No Internet connection');
    }

    return responseJson;
  }
}
