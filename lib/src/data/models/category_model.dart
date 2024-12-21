import 'package:ecommerce/src/domain/entities/category.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategroyModel extends Category {
  const CategroyModel(
      {required String id,
      required String description,
      required String name,
      required String imageURL})
      : super(id: id, description: description, name: name, imageURL: imageURL);

  factory CategroyModel.fromJson(Map<String, dynamic> json) =>
      _$CategroyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategroyModelToJson(this);
}
