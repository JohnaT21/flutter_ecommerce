import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/core/network/network_info.dart';
import 'package:ecommerce/src/data/models/user_model.dart';
import 'package:ecommerce/src/domain/entities/profile_model.dart';
import 'package:logger/logger.dart';

import '../../domain/repositories/account_repo.dart';
import '../data_sources/account_datasource.dart';

class AccountRepositoryImpl implements AccountRepo {
  final AccountRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, ProfileModel>> getAccount() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.getAccount();
        return Right(profileModelFromJson(json.encode(remoteUser)));
      } catch (e) {
        Logger().d(e.toString());
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }

  @override
  Future<Either<String,String>> updateAccount(Map<String, String> userModel,String? ppImage) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.updateAccount(userModel,ppImage);
        return Right(remoteUser);
      } catch (e) {
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }

  @override
  Future<Either<String, String>> updateDeviceToken({required String deviceToken})async {
    if(await networkInfo.isConnected){
      try{
        final remoteUser = await remoteDataSource.updateDeviceToken(deviceToken: deviceToken);
        return Right(remoteUser);
      }catch(e){
        return Left(e.toString());
      }
    }
    return const Left('Please check your connection!');
  }
}
