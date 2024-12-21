// To parse this JSON data, do
//
//     final shopResponse = shopResponseFromJson(jsonString);

import 'dart:convert';

ShopResponse shopResponseFromJson(String str) =>
    ShopResponse.fromJson(json.decode(str));

String shopResponseToJson(ShopResponse data) => json.encode(data.toJson());

class ShopResponse {
  ShopResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
    required this.metaData,
  });

  bool success;
  int code;
  String message;
  List<Shop>? data;
  MetaData metaData;

  factory ShopResponse.fromJson(Map<String, dynamic> json) => ShopResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<Shop>.from(json["data"].map((x) => Shop.fromJson(x))),
        metaData: MetaData.fromJson(json["metaData"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<Shop>.from(data!.map((x) => x.toJson())),
        "metaData": metaData.toJson(),
      };
}

class Shop {
  Shop({
    this.name,
    this.address,
    this.link,
    this.phoneNumber,
    this.logo,
    this.id,
    this.deleted,
  });

  String? name;
  String? address;
  String? link;
  String? phoneNumber;
  String? logo;
  String? id;
  bool? deleted;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        name: json["name"],
        address: json["address"],
        link: json["link"],
        phoneNumber: json["phone_number"],
        logo: json["logo"],
        id: json["_id"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "link": link,
        "phone_number": phoneNumber,
        "logo": logo,
        "_id": id,
        "deleted": deleted,
      };
}

class MetaData {
  MetaData();

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData();

  Map<String, dynamic> toJson() => {};
}
