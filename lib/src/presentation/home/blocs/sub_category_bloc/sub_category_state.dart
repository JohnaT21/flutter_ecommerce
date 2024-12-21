import 'package:ecommerce/src/data/models/sub_category_model.dart';
import 'package:equatable/equatable.dart';

abstract class SubCategoryState extends Equatable {
  const SubCategoryState();
  @override
  List<Object> get props => [];
}

class SubCategoriesInitial extends SubCategoryState {}

class SubCategoriesLoading extends SubCategoryState {}

class SubCategoriesLoaded extends SubCategoryState {
  final List<SubCategoryModel> subCategories;
  const SubCategoriesLoaded({required this.subCategories});
}

class SubCategoriesError extends SubCategoryState {
  final String error;
  const SubCategoriesError({required this.error});
}
