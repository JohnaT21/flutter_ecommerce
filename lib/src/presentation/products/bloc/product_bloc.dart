import 'package:ecommerce/src/data/models/products_response_model.dart';
import 'package:ecommerce/src/domain/usecases/product_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUsecase productRepo;
  ProductBloc({required this.productRepo}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is LoadProducts) {
        var response = await productRepo.getProducts();

        response.fold((error) {
          emit(
            ProductError(message: error),
          );
        }, (res) {
          emit(
            ProductLoaded(status: true, products: res),
          );
        });
      }
    });
  }
}
