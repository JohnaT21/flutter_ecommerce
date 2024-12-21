import 'package:ecommerce/src/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  @override
  final String name;
  @override
  final String description;
  @override
  final List<String> images;

  const ProductModel({
    required this.name,
    required this.description,
    required this.images,
  }) : super(name: name, description: description, images: images);
}
