import 'package:ecommerce/src/domain/entities/sub_category.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sub_category_model.g.dart';
@JsonSerializable()
class SubCategoryModel extends SubCategory{
  SubCategoryModel({
    required String id,
    required String name,
    required String description,
    required List<String> imageURL,
  }):super(id:id,name: name,description: description,imageURL: imageURL );
  
  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryModelToJson(this);
}