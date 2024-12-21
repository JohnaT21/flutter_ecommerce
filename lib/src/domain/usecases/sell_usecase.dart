import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/regions_model.dart';
import 'package:ecommerce/src/domain/entities/add_product_model.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/product_category.dart';
import '../repositories/sell_repo.dart';

class SellUsecase {
  final SellRepo sellRepo;

  SellUsecase({required this.sellRepo});

  Future<Either<String, ProductCategory>> getProductCategory() {
    return sellRepo.getProductCategory();
  }

  Future<Either<String, RegionModel>> getRegions() {
    return sellRepo.getRegions();
  }

  Future<Either<String, String>> addProduct(
      {required AddProductModel addProductModel}) {
    return sellRepo.addProduct(addProductModel: addProductModel);
  }

  Future<Either<String, dynamic>> addProductImage(
      {required List<XFile>? formdata, required String pId}) {
    return sellRepo.addProductImage(formdata: formdata, pId: pId);
  }
}
