import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/product_detail_model.dart';
import 'package:ecommerce/src/domain/repositories/product_detail_repo.dart';

class ProductDetailUsecase {
  final ProductDetailRepo detailRepo;

  ProductDetailUsecase({required this.detailRepo});

  Future<Either<String, ProductDetailResponse>> getProductDetail(
      String parentId) {
    return detailRepo.getProductDetail(parentId);
  }
}
