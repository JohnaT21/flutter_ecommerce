import 'package:ecommerce/src/data/models/shop_model.dart';
import 'package:equatable/equatable.dart';

abstract class ShopState extends Equatable {
  const ShopState();
  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final ShopResponse shops;
  ShopLoaded({required this.shops});
}

class ShopError extends ShopState {
  final String error;
  ShopError({required this.error});
}
