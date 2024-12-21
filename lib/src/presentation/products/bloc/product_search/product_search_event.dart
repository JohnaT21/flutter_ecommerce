part of 'product_search_bloc.dart';

abstract class ProductSearchEvent extends Equatable {
  const ProductSearchEvent();
}
class SearchProducts extends ProductSearchEvent {
  final String query;
  const SearchProducts({required this.query});

  @override
  List<Object?> get props => [];
}

