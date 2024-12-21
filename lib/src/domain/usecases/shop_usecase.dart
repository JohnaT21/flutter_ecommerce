import '../repositories/shop_repo.dart';

class ShopUseCase {
  ShopRepo shopRepo;
  ShopUseCase({required this.shopRepo});

  Future<dynamic> getAllShops() async {
    return await shopRepo.getAllShops();
  }
}
