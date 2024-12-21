import 'package:ecommerce/src/data/models/products_response_model.dart';
import 'package:ecommerce/src/domain/usecases/product_usecase.dart';
import 'package:ecommerce/src/presentation/products/bloc/related_product/related_product_event.dart';
import 'package:ecommerce/src/presentation/products/bloc/related_product/related_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedProductBloc
    extends Bloc<RelatedProductsEvent, RelatedProductState> {
  final ProductUsecase productUsecase;
  RelatedProductBloc({required this.productUsecase})
      : super(RelatedProductInitState()) {
    // on<GetRelatedProducts>(
    //   (event, emit) async {
    //     emit(RelatedProductLoadingState());
    //     try {
    //       var relatedProducts =
    //           await productUsecase.getRelatedProducts(event.id);

    //       if (relatedProducts is ProductsResponse) {
    //         print(relatedProducts);
    //         emit(RelatedProductSucessState(products: relatedProducts));
    //       } else {
    //         emit(RelatedProductErrorState(error: relatedProducts));
    //       }
    //     } catch (e) {
    //       print(e.toString());
    //       emit(RelatedProductErrorState(error: e.toString()));
    //     }
    //   },
    // );
 
  }
}
