import 'package:ecommerce/src/domain/usecases/product_usecase.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_by_sub_category_bloc/product_by_sub_category_event.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_by_sub_category_bloc/product_by_sub_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBySubcategoryBloc
    extends Bloc<ProductsBySubcategoryEvent, ProductsBySubcategoryState> {
  final ProductUsecase productRepo;
  ProductsBySubcategoryBloc({required this.productRepo})
      : super(ProductsBySubcategoryInitial()) {
    on<GetProductsBySubcategory>((event, emit) async {
      emit(ProductsBySubcategoryLoading());

      final results = await productRepo.getProductsBySubcategory(event.id);

      results.fold((error) {
        emit(ProductsBySubcategoryError(error: error));
      }, (products) {
        emit(ProductsBySubcategoryLoaded(products: products));
      });
    });
  }
}
