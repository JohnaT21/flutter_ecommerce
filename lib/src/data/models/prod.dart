import 'package:ecommerce/src/domain/entities/prod_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prod.g.dart';

@JsonSerializable()
class ProdModel extends ProdEntity {
  const ProdModel(
      {required String id,
      required String name,
      required String description,
      required List<String> imagesURL})
      : super(
            id: id, name: name, description: description, imagesURL: imagesURL);
  factory ProdModel.fromJson(Map<String, dynamic> json) =>
      _$ProdModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProdModelToJson(this);
}
