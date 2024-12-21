part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteAddedState extends FavoriteState {}

class FavoriteRemovedState extends FavoriteState {}

class LoadingFavoriteState extends FavoriteState {}

class LoadedFavoriteState extends FavoriteState {
  final FavoriteResponse favorites;

  LoadedFavoriteState({required this.favorites});
}

class LoadedFavoriteErrorState extends FavoriteState {
  final String msg;

  LoadedFavoriteErrorState({required this.msg});
}
