import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/product_detail_model.dart';

abstract class ProductDetailRepo {
  Future<Either<String, ProductDetailResponse>> getProductDetail(
      String productId);
}
