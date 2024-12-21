import 'package:equatable/equatable.dart';

abstract class ProductsBySubcategoryEvent extends Equatable {
  const ProductsBySubcategoryEvent();
  @override
  List<Object> get props => [];
}

class GetProductsBySubcategory extends ProductsBySubcategoryEvent {
  final String id;

  const GetProductsBySubcategory({required this.id});
}
