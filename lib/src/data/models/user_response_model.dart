// import 'package:ecommerce/src/data/models/products_response_model.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'user_response_model.g.dart';
//
// @JsonSerializable(explicitToJson: true)
// class UserResponse {
//   UserResponse({
//     this.success,
//     this.code,
//     this.message,
//     this.data,
//     this.metaData,
//   });
//
//   bool? success;
//   int? code;
//   String? message;
//   Data? data;
//   MetaData? metaData;
//   factory UserResponse.fromJson(Map<String, dynamic> data) =>
//       _$UserResponseFromJson(data);
//
//   Map<String, dynamic> toJson() => _$UserResponseToJson(this);
// }
//
// @JsonSerializable(explicitToJson: true)
// class Data {
//   Data({
//     required this.user,
//     required this.tokens,
//   });
//
//   User user;
//   Tokens tokens;
//   factory Data.fromJson(Map<String, dynamic> data) => _$DataFromJson(data);
//
//   Map<String, dynamic> toJson() => _$DataToJson(this);
// }
//
// @JsonSerializable(explicitToJson: true)
// class Tokens {
//   Tokens({
//     required this.access,
//   });
//
//   Access access;
//   factory Tokens.fromJson(Map<String, dynamic> data) => _$TokensFromJson(data);
//
//   Map<String, dynamic> toJson() => _$TokensToJson(this);
// }
//
// @JsonSerializable()
// class Access {
//   Access({
//     required this.token,
//     required this.expires,
//   });
//
//   String token;
//   DateTime expires;
//   factory Access.fromJson(Map<String, dynamic> data) => _$AccessFromJson(data);
//
//   Map<String, dynamic> toJson() => _$AccessToJson(this);
// }
//
// @JsonSerializable()
// class User {
//   User({
//     required this.firstName,
//     required this.lastName,
//     required this.authType,
//     this.allergies,
//     this.code,
//     this.status,
//     this.email,
//     this.imageUrl,
//     required this.isEmailVerified,
//     required this.id,
//   });
//   @JsonKey(name: "first_name")
//   String firstName;
//   @JsonKey(name: "last_name")
//   String lastName;
//   @JsonKey(name: "auth_type")
//   String authType;
//   List<dynamic>? allergies;
//   String? code;
//   String? status;
//   String? email;
//   List<dynamic>? imageUrl;
//   bool isEmailVerified;
//   String id;
//
//   factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
//
//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }
// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
    required this.metaData,
  });

  bool success;
  int code;
  String message;
  Data data;
  MetaData metaData;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        metaData: MetaData.fromJson(json["metaData"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
        "metaData": metaData.toJson(),
      };
}

class Data {
  Data({
    required this.user,
    required this.tokens,
  });

  User user;
  Tokens tokens;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "tokens": tokens.toJson(),
      };
}

class Tokens {
  Tokens({
    required this.access,
  });

  Access access;

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: Access.fromJson(json["access"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access.toJson(),
      };
}

class Access {
  Access({
    required this.token,
    required this.expires,
  });

  String token;
  DateTime expires;

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json["token"],
        expires: DateTime.parse(json["expires"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expires": expires.toIso8601String(),
      };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.authType,
    required this.allergies,
    required this.code,
    required this.status,
    required this.email,
    required this.phone,
    required this.isEmailVerified,
  });

  String id;
  String firstName;
  String lastName;
  String authType;
  List<dynamic> allergies;
  String code;
  String status;
  String email;
  String phone;
  bool isEmailVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        authType: json["auth_type"],
        allergies: List<dynamic>.from(json["allergies"].map((x) => x)),
        code: json["code"],
        status: json["status"],
        email: json["email"],
        phone: json["phone"],
        isEmailVerified: json["isEmailVerified"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "auth_type": authType,
        "allergies": List<dynamic>.from(allergies.map((x) => x)),
        "code": code,
        "status": status,
        "email": email,
        "phone": phone,
        "isEmailVerified": isEmailVerified,
      };
}

class MetaData {
  MetaData();

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData();

  Map<String, dynamic> toJson() => {};
}
