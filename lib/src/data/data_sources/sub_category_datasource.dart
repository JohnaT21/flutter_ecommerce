import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/data/models/sub_category_model.dart';
import 'package:ecommerce/src/di/injector.dart';

class SubCategoryDataSource {
  final dioClient = sl.get<Dio>();
  final baseApiUrl = BASE_API_URL;

  Future<List<SubCategoryModel>> getSubCategories(String categoryId) async {
    try {
      final response = await dioClient
          .get("$baseApiUrl/categories/$categoryId/subcategories");
      final List<dynamic> subCategories = response.data["data"] as List;
      return subCategories
          .map((subCategory) => SubCategoryModel.fromJson(subCategory))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
