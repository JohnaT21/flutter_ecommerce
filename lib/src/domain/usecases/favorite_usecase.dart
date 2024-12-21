import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/favorite_model.dart';

import '../repositories/favorite_repo.dart';

class FavoriteUsecase {
  final FavoriteRepo favoriteRepo;

  FavoriteUsecase({required this.favoriteRepo});

  Future<Either<String, FavoriteResponse>> getFavorites() {
    return favoriteRepo.getFavorites();
  }

  Future<dynamic> addToFavorite(String product) {
    return favoriteRepo.addToFavorite(product);
  }

  Future<dynamic> removeFromFavorite(String product) {
    return removeFromFavorite(product);
  }
}
