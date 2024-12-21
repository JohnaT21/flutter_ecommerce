
import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/core/network/network_info.dart';
import 'package:ecommerce/src/data/models/regions_model.dart';
import 'package:ecommerce/src/domain/entities/add_product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/product_category.dart';
import '../../domain/repositories/sell_repo.dart';
import '../data_sources/sell_data_source.dart';

class SellRepositoryImpl implements SellRepo {
  final SellRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SellRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, ProductCategory>> getProductCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getProductCategory();
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }

  @override
  Future<Either<String, String>> addProduct(
      {required AddProductModel addProductModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.addProduct(addProductModel: addProductModel);
        Logger().d(response);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }

  @override
  Future<Either<String, dynamic>> addProductImage(
      {required List<XFile>? formdata, required String pId}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.addProductImage(
            formdata: formdata, pId: pId);
        Logger().d(response);
        return Right(response);
      } catch (e) {
        Logger().d(e.toString());
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }

  @override
  Future<Either<String, RegionModel>> getRegions() async{
   if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getRegions();
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }
}
