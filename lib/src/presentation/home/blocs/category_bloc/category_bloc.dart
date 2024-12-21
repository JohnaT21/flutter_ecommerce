import 'package:ecommerce/src/data/models/category_model.dart';
import 'package:ecommerce/src/domain/usecases/home_categories_usecase.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_event.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final HomeCategory homeCategory;
  CategoryBloc({required this.homeCategory}) : super(CategoriesInitial()) {
    on<GetCategories>(
      (event, emit) async {
        emit(CategoriesLoading());
        try {
          List<CategroyModel> categories =
              await homeCategory.getAllCategories();
          emit(CategoriesLoaded(categories: categories));
        } catch (e) {
          emit(CategoriesError(error: e.toString()));
        }
      },
    );
  }
}
