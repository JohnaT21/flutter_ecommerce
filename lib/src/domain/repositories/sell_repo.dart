import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/regions_model.dart';
import 'package:ecommerce/src/domain/entities/add_product_model.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/product_category.dart';

abstract class SellRepo {
  Future<Either<String, ProductCategory>> getProductCategory();
  Future<Either<String, RegionModel>> getRegions();
  Future<Either<String, String>> addProduct(
      {required AddProductModel addProductModel});
  Future<Either<String, dynamic>> addProductImage(
      {required List<XFile>? formdata, required String pId});
}
