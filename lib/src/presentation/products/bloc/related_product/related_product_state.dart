
import 'package:ecommerce/src/data/models/products_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class RelatedProductState extends Equatable{

 @override
  List<Object> get props => [];
}

class RelatedProductInitState extends RelatedProductState{}
class RelatedProductLoadingState extends RelatedProductState{}
class RelatedProductSucessState extends RelatedProductState{
  final ProductsResponse products;
  RelatedProductSucessState({required this.products});
}
class RelatedProductErrorState extends RelatedProductState{
   final String error;
   RelatedProductErrorState({required this.error});
}
