import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/product_by_category_model.dart';
import 'package:ecommerce/src/domain/repositories/product_repo.dart';

import '../../data/models/products_response_model.dart';

class ProductUsecase {
  final ProductRepo productRepo;

  ProductUsecase({required this.productRepo});

  Future<Either<String, ProductsResponse>> getProducts() {
    return productRepo.getProducts();
  }

  Future<Either<String,ProductByCategoryModel>> getProductsBySubcategory(String subCategoryId) {
    return productRepo.getProductsBySubcategory(subCategoryId);
  }

  Future<ProductsResponse> searchProducts(String query) async {
    return await productRepo.searchProducts(query: query);
  }

  Future<ProductsResponse> filterProductsById(String sellerId) async {
    return await productRepo.filterProductsById(sellerId: sellerId);
  }

  Future<dynamic> getRelatedProducts(String productId) async {
    return productRepo.getRelatedProducts(productId);
  }
}
