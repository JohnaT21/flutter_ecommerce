part of 'product_filter_bloc.dart';

abstract class ProductFilterEvent extends Equatable {
  const ProductFilterEvent();
}

class ProductFilterById extends ProductFilterEvent{

  String sellerId;
  ProductFilterById({
    required this.sellerId
  });
  @override
  List<Object?> get props => [sellerId];

}
