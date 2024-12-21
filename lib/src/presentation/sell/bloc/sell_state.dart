part of 'sell_bloc.dart';

abstract class SellState extends Equatable {
  // final SubcategoryElement? subcategoryElement;
  const SellState();

  @override
  List<Object> get props => [];
}

class SellInitial extends SellState {}

///product category
class GetProductCategoryLoading extends SellState {}

class ChangeValueState extends SellState {
  final List<res.Values> values;
  const ChangeValueState({required this.values});
}

class GetProductCategorySuccess extends SellState {
  final res.ProductCategory productCategory;
  const GetProductCategorySuccess({required this.productCategory});

  @override
  List<Object> get props => [productCategory];
}

class GetProductCategoryError extends SellState {
  final String message;

  const GetProductCategoryError({required this.message});

  @override
  List<Object> get props => [message];
}

///Add product
class AddProductLoading extends SellState {}

class AddProductSuccess extends SellState {
  final String productId;
  const AddProductSuccess({required this.productId});

  @override
  List<Object> get props => [productId];
}

class AddProductError extends SellState {
  final String message;

  const AddProductError({required this.message});

  @override
  List<Object> get props => [message];
}

///Add product
class AddProductImageLoading extends SellState {}

class AddProductImageSuccess extends SellState {
  final dynamic msg;
  const AddProductImageSuccess({required this.msg});

  @override
  List<Object> get props => [msg];
}

class AddProductImageError extends SellState {
  final String message;

  const AddProductImageError({required this.message});

  @override
  List<Object> get props => [message];
}

///fectch regions
class FetchRegionLoading extends SellState {}

class FetchRegionSuccess extends SellState {
  final RegionModel regionModel;
  const FetchRegionSuccess({required this.regionModel});

  @override
  List<Object> get props => [regionModel];
}

class FetchRegionError extends SellState {
  final String message;

  const FetchRegionError({required this.message});

  @override
  List<Object> get props => [message];
}
