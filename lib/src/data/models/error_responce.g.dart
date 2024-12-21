// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_responce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponce _$ErrorResponceFromJson(Map<String, dynamic> json) =>
    ErrorResponce(
      success: json['success'] as bool,
      error: Error.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ErrorResponceToJson(ErrorResponce instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error.toJson(),
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      code: json['code'] as int,
      message: json['message'] as String,
      fieldError: (json['fieldError'] as List<dynamic>)
          .map((e) => FieldError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'fieldError': instance.fieldError.map((e) => e.toJson()).toList(),
    };

FieldError _$FieldErrorFromJson(Map<String, dynamic> json) => FieldError(
      name: json['name'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$FieldErrorToJson(FieldError instance) =>
    <String, dynamic>{
      'name': instance.name,
      'message': instance.message,
    };
