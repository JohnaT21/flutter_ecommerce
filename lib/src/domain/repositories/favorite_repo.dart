import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/favorite_model.dart';

abstract class FavoriteRepo {
  Future<Either<String, FavoriteResponse>> getFavorites();
  Future<dynamic> addToFavorite(String product);
  Future<dynamic> removeFromFavorite(String product);
}
