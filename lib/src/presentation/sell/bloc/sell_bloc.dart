import 'package:bloc/bloc.dart';
import 'package:ecommerce/src/data/models/regions_model.dart';
import 'package:ecommerce/src/domain/entities/add_product_model.dart' as pm;
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../domain/entities/product_category.dart' as res;
import '../../../domain/usecases/sell_usecase.dart';

part 'sell_event.dart';
part 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  final SellUsecase productCategoryUsecase;

  SellBloc({required this.productCategoryUsecase}) : super(SellInitial()) {
    on<SellEvent>((event, emit) async {
      if (event is GetProductCategoryEvent) {
        emit(GetProductCategoryLoading());
        var fold = await productCategoryUsecase.getProductCategory();
        fold.fold(
            (error) => emit(GetProductCategoryError(message: error)),
            (success) =>
                emit(GetProductCategorySuccess(productCategory: success)));
      }
      if (event is GetRegionsEvent) {
        emit(FetchRegionLoading());
        var fold = await productCategoryUsecase.getRegions();
        fold.fold((error) => emit(FetchRegionError(message: error)), (success) {
          Logger().d(success);
          emit(FetchRegionSuccess(regionModel: success));
        });
      }
      if (event is AddProductEvent) {
        Logger().d("hehehehe......");
        emit(AddProductLoading());
        var fold = await productCategoryUsecase.addProduct(
            addProductModel: event.addProductModel);
        fold.fold(
          (error) {
            emit(
              AddProductError(message: error),
            );
          },
          (success) {
            Logger().d(success);
            emit(
              AddProductSuccess(productId: success),
            );
          },
        );
      }
      if (event is AddProductImageEvent) {
        Logger().d("hehehehe......");
        emit(AddProductImageLoading());
        var fold = await productCategoryUsecase.addProductImage(
            formdata: event.formData, pId: event.pId);
        fold.fold(
          (error) {
            Logger().d(error);
            emit(
              AddProductImageError(message: error),
            );
          },
          (success) {
            Logger().d(success);
            emit(
              AddProductImageSuccess(msg: success),
            );
          },
        );
      }

      // if (event is ChangeValueEvent) {
      //   Logger().d(event.values);
      //   emit(ChangeValueState(values: event.values));
      // }
    });
  }
}
