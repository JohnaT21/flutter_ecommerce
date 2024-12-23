part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class GetProductsDetail extends ProductDetailEvent {
  final String productId;

  const GetProductsDetail({required this.productId});
}
