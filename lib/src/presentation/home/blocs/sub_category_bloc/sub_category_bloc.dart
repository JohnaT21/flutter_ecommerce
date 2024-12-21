import 'package:ecommerce/src/data/models/sub_category_model.dart';
import 'package:ecommerce/src/domain/usecases/home__sub_category_usecase.dart';
import 'package:ecommerce/src/presentation/home/blocs/sub_category_bloc/sub_category_event.dart';
import 'package:ecommerce/src/presentation/home/blocs/sub_category_bloc/sub_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  final HomeSubCateogry homeSubCateogry;
  SubCategoryBloc({required this.homeSubCateogry})
      : super(SubCategoriesInitial()) {
    on<GetSubCategories>(
      (event, emit) async {
        emit(SubCategoriesLoading());

        final String categoryId = event.id;
        try {
          List<SubCategoryModel> subCategories =
              await homeSubCateogry.getSubCategories(categoryId);
          emit(SubCategoriesLoaded(subCategories: subCategories));
        } catch (e) {
          emit(SubCategoriesError(error: e.toString()));
        }
      },
    );
  }
}
