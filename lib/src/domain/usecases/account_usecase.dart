import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/domain/entities/profile_model.dart';

import '../repositories/account_repo.dart';

class AccountUsecase {
  final AccountRepo accountRepo;

  AccountUsecase({required this.accountRepo});

  Future<Either<String, ProfileModel>> getAccount() {
    return accountRepo.getAccount();
  }

  Future<Either<String, String>> updateAccount(
      Map<String, String> userModel, String? ppImage) {
    return accountRepo.updateAccount(userModel, ppImage);
  }

  Future<Either<String, String>> updateDeviceToken(
      {required String deviceToken}) {
    return accountRepo.updateDeviceToken(deviceToken: deviceToken);
  }
}
