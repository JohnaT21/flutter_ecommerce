import 'package:ecommerce/src/data/models/product_by_category_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsBySubcategoryState extends Equatable {
  const ProductsBySubcategoryState();
  @override
  List<Object> get props => [];
}

class ProductsBySubcategoryInitial extends ProductsBySubcategoryState {}

class ProductsBySubcategoryLoading extends ProductsBySubcategoryState {}

class ProductsBySubcategoryLoaded extends ProductsBySubcategoryState {
  final ProductByCategoryModel products;
  const ProductsBySubcategoryLoaded({required this.products});
}

class ProductsBySubcategoryError extends ProductsBySubcategoryState {
  final String error;
  const ProductsBySubcategoryError({required this.error});
}
