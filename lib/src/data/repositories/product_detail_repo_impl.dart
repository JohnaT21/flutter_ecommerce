import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/core/network/network_info.dart';
import 'package:ecommerce/src/data/data_sources/product_detail_datasource.dart';
import 'package:ecommerce/src/data/models/product_detail_model.dart';
import 'package:ecommerce/src/domain/repositories/product_detail_repo.dart';
import 'package:logger/logger.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepo {
  final ProductDetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, ProductDetailResponse>> getProductDetail(
      String productId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getProductDetail(productId);
        return Right(response);
      } catch (e) {
        Logger().d(e);
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }
}
