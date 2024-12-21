import 'package:ecommerce/src/domain/usecases/shop_usecase.dart';
import 'package:ecommerce/src/presentation/home/blocs/shop_bloc/shop_event.dart';
import 'package:ecommerce/src/presentation/home/blocs/shop_bloc/shop_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/shop_model.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopUseCase shopUseCase;
  ShopBloc({required this.shopUseCase}) : super(ShopInitial()) {
    on<GetShop>(
      (event, emit) async {
        emit(ShopLoading());
        try {
          var shops = await shopUseCase.getAllShops();
          if (shops is ShopResponse) {
            emit(ShopLoaded(shops: shops));
          } else {
            emit(ShopError(error: shops.error.message));
          }
        } catch (e) {
          emit(ShopError(error: e.toString()));
        }
      },
    );
  }
}
