import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageURL;
  const Category(
      {required this.id,
      required this.description,
      required this.name,
      required this.imageURL});

  @override
  List<Object?> get props => [id, name, description, imageURL];
}
