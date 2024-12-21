import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/models/error_responce.dart';
import '../../../data/models/favorite_model.dart';
import '../../../domain/usecases/favorite_usecase.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteUsecase favoriteUsecase;
  FavoriteBloc(this.favoriteUsecase) : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async {
      if (event is GetAllFavoriteEvent) {
        emit(LoadingFavoriteState());
        var result = await favoriteUsecase.getFavorites();

        result.fold((error) {
          emit(LoadedFavoriteErrorState(msg: error));
        }, (res) {
          emit(LoadedFavoriteState(favorites: res));
        });
      }
      if (event is AddToFavoriteEvent) {
        emit(LoadingFavoriteState());
        var result = await favoriteUsecase.addToFavorite(event.product);
        print("Add to fav.......................");
        print(result);
        if (result is Error) {
          emit(LoadedFavoriteErrorState(msg: result.message));
        } else if (result is FavoriteResponse) {
          emit(LoadedFavoriteState(favorites: result));
        } else {
          emit(LoadedFavoriteErrorState(msg: "Error occurred"));
        }
      }
      if (event is RemoveFromFavoriteEvent) {
        emit(LoadingFavoriteState());
        var result = await favoriteUsecase.removeFromFavorite(event.product);
        emit(LoadedFavoriteState(favorites: result));
      }
    });
  }
}
