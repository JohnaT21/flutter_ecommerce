import 'package:json_annotation/json_annotation.dart';
part 'error_responce.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorResponce {
  ErrorResponce({
    required this.success,
    required this.error,
  });

  bool success;
  Error error;
  factory ErrorResponce.fromJson(Map<String, dynamic> data) =>
      _$ErrorResponceFromJson(data);

  Map<String, dynamic> toJson() => _$ErrorResponceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Error {
  Error({
    required this.code,
    required this.message,
    required this.fieldError,
  });

  int code;
  String message;
  List<FieldError> fieldError;

  factory Error.fromJson(Map<String, dynamic> data) => _$ErrorFromJson(data);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}

@JsonSerializable()
class FieldError {
  FieldError({
    required this.name,
    required this.message,
  });

  String name;
  String message;

  factory FieldError.fromJson(Map<String, dynamic> data) =>
      _$FieldErrorFromJson(data);

  Map<String, dynamic> toJson() => _$FieldErrorToJson(this);
}
