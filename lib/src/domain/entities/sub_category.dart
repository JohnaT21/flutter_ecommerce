import 'package:equatable/equatable.dart';

class SubCategory extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> imageURL;
  const SubCategory(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageURL});

  @override
  List<Object?> get props => [];
}
