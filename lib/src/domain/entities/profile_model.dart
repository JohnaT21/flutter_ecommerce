// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.authType,
    required this.allergies,
    required this.code,
    required this.status,
    required this.email,
    required this.phone,
    this.imageURL,
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
  String? imageURL;
  bool isEmailVerified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        authType: json["auth_type"],
        allergies: List<dynamic>.from(json["allergies"].map((x) => x)),
        code: json["code"],
        status: json["status"],
        email: json["email"],
        phone: json["phone"],
        imageURL: json["imageURL"],
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
        "imageURL": imageURL,
        "isEmailVerified": isEmailVerified,
      };
}

class MetaData {
  MetaData();

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData();

  Map<String, dynamic> toJson() => {};
}
