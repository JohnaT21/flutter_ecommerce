import 'package:ecommerce/src/domain/repositories/shop_repo.dart';

import '../../core/network/network_info.dart';
import '../data_sources/shop_datasource.dart';

class ShopRepoImpl implements ShopRepo {
  final NetworkInfo networkInfo;
  final ShopDataSource shopDataSource;

  ShopRepoImpl(this.shopDataSource, this.networkInfo);

  @override
  Future getAllShops() async {
    if (await networkInfo.isConnected) {
      return shopDataSource.getAllShops();
    } else {
      return "Please check your connection!";
    }
  }
}
