import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/data_sources/favorite_data_source.dart';
import 'package:ecommerce/src/data/models/favorite_model.dart';
import 'package:ecommerce/src/domain/repositories/favorite_repo.dart';

import '../../core/network/network_info.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final FavoriteDataSource favoriteDataSource;
  final NetworkInfo networkInfo;
  FavoriteRepoImpl(this.favoriteDataSource, this.networkInfo);

  @override
  Future addToFavorite(String product) async {
    if (await networkInfo.isConnected) {
      return favoriteDataSource.addToFavorite(product: product);
    } else {
      return "Please check your connection!";
    }
  }

  @override
  Future<Either<String, FavoriteResponse>> getFavorites() async {
    if (await networkInfo.isConnected) {
      var res = await favoriteDataSource.getFavorites();
      return Right(res);
    } else {
      return const Left("Please check your connection!");
    }
  }

  @override
  Future removeFromFavorite(String product) async {
    if (await networkInfo.isConnected) {
      return favoriteDataSource.removeFromFavorite(product: product);
    } else {
      return "Please check your connection!";
    }
  }
}
