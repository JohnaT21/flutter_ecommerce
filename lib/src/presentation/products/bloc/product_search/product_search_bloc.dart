import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/products_response_model.dart';
import '../../../../domain/usecases/product_usecase.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  final ProductUsecase productUsecase;
  ProductSearchBloc({required this.productUsecase})
      : super(ProductSearchInitial()) {
    on<ProductSearchEvent>((event, emit) async {
      if (event is SearchProducts) {
        try {
          emit(ProductSearchLoading());
          final products = await productUsecase.searchProducts(event.query);
          emit(ProductSearchLoaded(products: products.product!));
        } catch (e) {
          emit(ProductSearchError(message: e.toString()));
        }
      }
    });
  }
}
