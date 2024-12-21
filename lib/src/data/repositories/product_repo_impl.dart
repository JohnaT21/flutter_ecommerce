import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/data_sources/product_data_source.dart';
import 'package:ecommerce/src/data/models/product_by_category_model.dart';
import 'package:ecommerce/src/data/models/products_response_model.dart';
import 'package:ecommerce/src/domain/repositories/product_repo.dart';

import '../../core/network/network_info.dart';

class ProductRepoImpl implements ProductRepo {
  final NetworkInfo networkInfo;
  final ProductDataSource productDataSource;

  ProductRepoImpl(this.productDataSource, this.networkInfo);

  @override
  Future<Either<String, ProductsResponse>> getProducts() async {
    if (await networkInfo.isConnected) {
      final res = await productDataSource.getProducts();
      return Right(res);
    } else {
      return const Left("Please check your connection!");
    }
  }

  @override
  Future<Either<String, ProductByCategoryModel>> getProductsBySubcategory(
      String subCategoryId) async {
    if (await networkInfo.isConnected) {
      var res = await productDataSource.getProductsBySubcategory(subCategoryId);
      return Right(res);
    } else {
      return const Left("Please check your connection!");
    }
  }

  @override
  Future<ProductsResponse> searchProducts({required String query}) {
    return productDataSource.searchProducts(query: query);
  }

  @override
  Future<ProductsResponse> filterProductsById({required String sellerId}) {
    return productDataSource.filterProductsById(sellerId: sellerId);
  }

  @override
  Future getRelatedProducts(String productId) {
    return productDataSource.getRelatedProducts(productId);
  }
}
