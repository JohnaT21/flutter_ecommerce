// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdModel _$ProdModelFromJson(Map<String, dynamic> json) => ProdModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imagesURL:
          (json['imagesURL'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProdModelToJson(ProdModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imagesURL': instance.imagesURL,
    };
