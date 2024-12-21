import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/domain/entities/profile_model.dart';

abstract class AccountRepo {
  Future<Either<String, ProfileModel>> getAccount();
  Future<Either<String, String>> updateAccount(
      Map<String, String> userModel, String? ppImage);
  Future<Either<String, String>> updateDeviceToken(
      {required String deviceToken});
}
