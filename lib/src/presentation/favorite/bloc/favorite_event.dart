part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToFavoriteEvent extends FavoriteEvent {
  final String product;

  AddToFavoriteEvent({required this.product});
}

class GetAllFavoriteEvent extends FavoriteEvent {
  GetAllFavoriteEvent();
}

class RemoveFromFavoriteEvent extends FavoriteEvent {
  final String product;

  RemoveFromFavoriteEvent({required this.product});
}
