import 'package:ecommerce/src/data/models/category_model.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoryState {}

class CategoriesLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<CategroyModel> categories;
  const CategoriesLoaded({required this.categories});
}

class CategoriesError extends CategoryState {
  final String error;
  const CategoriesError({required this.error});
}
