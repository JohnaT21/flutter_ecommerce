// To parse this JSON data, do
//
//     final favoriteResponse = favoriteResponseFromJson(jsonString);

import 'dart:convert';

FavoriteResponse favoriteResponseFromJson(String str) =>
    FavoriteResponse.fromJson(json.decode(str));

String favoriteResponseToJson(FavoriteResponse data) =>
    json.encode(data.toJson());

class FavoriteResponse {
  FavoriteResponse({
    this.success,
    this.code,
    this.message,
    this.data,
    this.metaData,
  });

  bool? success;
  int? code;
  String? message;
  List<Datum>? data;
  MetaData? metaData;

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      FavoriteResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        metaData: json["metaData"] == null
            ? null
            : MetaData.fromJson(json["metaData"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "metaData": metaData?.toJson(),
      };
}

class Datum {
  Datum({
    this.id,
    this.user,
    this.product,
    this.state,
  });

  String? id;
  String? user;
  FavProduct? product;
  String? state;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        user: json["user"],
        product: json["product"] == null
            ? null
            : FavProduct.fromJson(json["product"]),
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "product": product?.toJson(),
        "state": state,
      };
}

class FavProduct {
  FavProduct({
    this.id,
    this.name,
    this.description,
    this.imagesUrl,
    this.price,
    this.subcategory,
    this.options,
    this.seller,
    this.featured,
    this.premium,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.datumId,
  });

  String? id;
  String? name;
  String? description;
  List<String>? imagesUrl;
  int? price;
  Subcategory? subcategory;
  List<Option>? options;
  Seller? seller;
  bool? featured;
  bool? premium;
  String? state;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? datumId;

  factory FavProduct.fromJson(Map<String, dynamic> json) => FavProduct(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        imagesUrl: json["imagesURL"] == null
            ? []
            : List<String>.from(json["imagesURL"]!.map((x) => x)),
        price: json["price"],
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"]),
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        featured: json["featured"],
        premium: json["premium"],
        state: json["state"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "imagesURL": imagesUrl == null
            ? []
            : List<dynamic>.from(imagesUrl!.map((x) => x)),
        "price": price,
        "subcategory": subcategory?.toJson(),
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "seller": seller?.toJson(),
        "featured": featured,
        "premium": premium,
        "state": state,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": datumId,
      };
}

class Option {
  Option({
    this.optionId,
    this.values,
    this.others,
    this.id,
  });

  Id? optionId;
  List<Value>? values;
  List<dynamic>? others;
  String? id;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionId: json["id"] == null ? null : Id.fromJson(json["id"]),
        values: json["values"] == null
            ? []
            : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
        others: json["others"] == null
            ? []
            : List<dynamic>.from(json["others"]!.map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": optionId?.toJson(),
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
        "others":
            others == null ? [] : List<dynamic>.from(others!.map((x) => x)),
        "_id": id,
      };
}

class Id {
  Id({
    this.id,
    this.subcategory,
    this.inputType,
    this.name,
    this.deletedAt,
    this.deleted,
    this.idId,
  });

  String? id;
  String? subcategory;
  String? inputType;
  String? name;
  dynamic deletedAt;
  bool? deleted;
  String? idId;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["_id"],
        subcategory: json["subcategory"],
        inputType: json["input_type"],
        name: json["name"],
        deletedAt: json["deletedAt"],
        deleted: json["deleted"],
        idId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subcategory": subcategory,
        "input_type": inputType,
        "name": name,
        "deletedAt": deletedAt,
        "deleted": deleted,
        "id": idId,
      };
}

class Value {
  Value({
    this.id,
    this.option,
    this.value,
    this.deletedAt,
    this.deleted,
  });

  String? id;
  String? option;
  String? value;
  dynamic deletedAt;
  bool? deleted;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["_id"],
        option: json["option"],
        value: json["value"],
        deletedAt: json["deletedAt"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "option": option,
        "value": value,
        "deletedAt": deletedAt,
        "deleted": deleted,
      };
}

class Seller {
  Seller({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.authType,
    this.allergies,
    this.code,
    this.status,
    this.email,
    this.isEmailVerified,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? authType;
  List<dynamic>? allergies;
  String? code;
  String? status;
  String? email;
  bool? isEmailVerified;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        authType: json["auth_type"],
        allergies: json["allergies"] == null
            ? []
            : List<dynamic>.from(json["allergies"]!.map((x) => x)),
        code: json["code"],
        status: json["status"],
        email: json["email"],
        isEmailVerified: json["isEmailVerified"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "auth_type": authType,
        "allergies": allergies == null
            ? []
            : List<dynamic>.from(allergies!.map((x) => x)),
        "code": code,
        "status": status,
        "email": email,
        "isEmailVerified": isEmailVerified,
      };
}

class Subcategory {
  Subcategory({
    this.id,
    this.name,
    this.description,
    this.deletedAt,
    this.imageUrl,
    this.category,
    this.subcategoryId,
  });

  String? id;
  String? name;
  String? description;
  dynamic deletedAt;
  List<String>? imageUrl;
  String? category;
  String? subcategoryId;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        deletedAt: json["deletedAt"],
        imageUrl: json["imageURL"] == null
            ? []
            : List<String>.from(json["imageURL"]!.map((x) => x)),
        category: json["category"],
        subcategoryId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "deletedAt": deletedAt,
        "imageURL":
            imageUrl == null ? [] : List<dynamic>.from(imageUrl!.map((x) => x)),
        "category": category,
        "id": subcategoryId,
      };
}

class MetaData {
  MetaData();

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData();

  Map<String, dynamic> toJson() => {};
}
