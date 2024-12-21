import 'package:bloc/bloc.dart';
import 'package:ecommerce/src/data/models/product_detail_model.dart';
import 'package:ecommerce/src/domain/usecases/product_detail_usecase.dart';
import 'package:equatable/equatable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailUsecase _productDetailUsecase;
  ProductDetailBloc(this._productDetailUsecase)
      : super(ProductDetailInitial()) {
    on<GetProductsDetail>((event, emit) async {
      emit(ProductDetailLoading());

      final results =
          await _productDetailUsecase.getProductDetail(event.productId);

      results.fold((error) {
        emit(ProductDetailError(error: error));
      }, (res) {
        emit(ProductDetailLoaded(detailResponse: res));
      });
    });
  }
}
