part of 'product_search_bloc.dart';

abstract class ProductSearchState extends Equatable {
  const ProductSearchState();
}

class ProductSearchInitial extends ProductSearchState {
  @override
  List<Object> get props => [];
}
class ProductSearchLoading extends ProductSearchState {
  @override
  List<Object> get props => [];
}

class ProductSearchLoaded extends ProductSearchState {
  final List<Product> products;

  const ProductSearchLoaded({required this.products});

  @override
  List<Object> get props => [products];
}


class ProductSearchError extends ProductSearchState {
  final String message;

  const ProductSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
