import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/data/models/category_model.dart';
import 'package:ecommerce/src/di/injector.dart';

class CategoryDataSource {
  final dioClient = sl.get<Dio>();
  final baseApiUrl = BASE_API_URL;

  Future<List<CategroyModel>> getAllCategories() async {
    try {
      final response = await dioClient.get("$baseApiUrl/categories");

      final List<dynamic> categories = response.data["data"] as List;

      return categories
          .map((category) => CategroyModel.fromJson(category))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
