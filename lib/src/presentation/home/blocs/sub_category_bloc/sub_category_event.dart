import 'package:equatable/equatable.dart';

abstract class SubCategoryEvent extends Equatable {
  const SubCategoryEvent();
  @override
  List<Object> get props => [];
}

class GetSubCategories extends SubCategoryEvent {
  final String id;

  const GetSubCategories({required this.id});
}
