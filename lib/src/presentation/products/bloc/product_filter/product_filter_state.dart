part of 'product_filter_bloc.dart';

abstract class ProductFilterState extends Equatable {
  const ProductFilterState();
}

class ProductFilterInitial extends ProductFilterState {
  @override
  List<Object> get props => [];
}
class ProductFilterLoading extends ProductFilterState {
  @override
  List<Object> get props => [];
}

class ProductFilterLoaded extends ProductFilterState{
  final List<Product> products;

  const ProductFilterLoaded({required this.products});

  @override
  List<Object> get props => [products];
}


class ProductFilterError extends ProductFilterState{
  final String message;

  const ProductFilterError({required this.message});

  @override
  List<Object> get props => [message];
}
