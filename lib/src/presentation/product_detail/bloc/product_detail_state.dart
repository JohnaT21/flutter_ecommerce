part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();
  
  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}
class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final ProductDetailResponse detailResponse;
  const ProductDetailLoaded({required this.detailResponse});
}

class ProductDetailError extends ProductDetailState {
  final String error;
  const ProductDetailError({required this.error});
}
