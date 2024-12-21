import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/products_response_model.dart';
import '../../../../domain/usecases/product_usecase.dart';

part 'product_filter_event.dart';
part 'product_filter_state.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvent, ProductFilterState> {
  final ProductUsecase productRepo;
  ProductFilterBloc({required this.productRepo})
      : super(ProductFilterInitial()) {
    on<ProductFilterEvent>((event, emit) async {
      if (event is ProductFilterById) {
        try {
          emit(ProductFilterLoading());
          final products = await productRepo.filterProductsById(event.sellerId);
          emit(ProductFilterLoaded(products: products.product!));
        } catch (e) {
          emit(ProductFilterError(message: e.toString()));
        }
      }
    });
  }
}
