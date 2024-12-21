import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String name;
  final String description;
  final List<String> images;

  const ProductEntity({
    required this.name,
    required this.description,
    required this.images,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
