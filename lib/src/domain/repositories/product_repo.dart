import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/product_by_category_model.dart';

import '../../data/models/products_response_model.dart';

abstract class ProductRepo {
  Future<Either<String, ProductsResponse>> getProducts();
  Future<Either<String, ProductByCategoryModel>> getProductsBySubcategory(
      String subCategoryId);
  Future searchProducts({required String query});
  Future filterProductsById({required String sellerId});
  Future<dynamic> getRelatedProducts(String productId);
}
