// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategroyModel _$CategroyModelFromJson(Map<String, dynamic> json) =>
    CategroyModel(
      id: json['id'] as String,
      description: json['description'] as String,
      name: json['name'] as String,
      imageURL: json['imageURL'] as String,
    );

Map<String, dynamic> _$CategroyModelToJson(CategroyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageURL': instance.imageURL,
    };
