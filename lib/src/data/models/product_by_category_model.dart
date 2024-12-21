// To parse this JSON data, do
//
//     final productByCategoryModel = productByCategoryModelFromJson(jsonString);

import 'dart:convert';

ProductByCategoryModel productByCategoryModelFromJson(String str) =>
    ProductByCategoryModel.fromJson(json.decode(str));

String productByCategoryModelToJson(ProductByCategoryModel data) =>
    json.encode(data.toJson());

class ProductByCategoryModel {
  ProductByCategoryModel({
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

  factory ProductByCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductByCategoryModel(
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

class Product {
  Product({
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
    this.viewCount,
    this.productId,
  });

  String? id;
  String? name;
  String? description;
  List<String>? imagesUrl;
  int? price;
  Data? subcategory;
  List<Option>? options;
  Seller? seller;
  bool? featured;
  bool? premium;
  String? state;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? viewCount;
  String? productId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        imagesUrl: List<String>.from(json["imagesURL"].map((x) => x)),
        price: json["price"],
        subcategory: Data.fromJson(json["subcategory"]),
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        seller: Seller.fromJson(json["seller"]),
        featured: json["featured"],
        premium: json["premium"],
        state: json["state"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        viewCount: json["viewCount"],
        productId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "imagesURL": List<dynamic>.from(imagesUrl!.map((x) => x)),
        "price": price,
        "subcategory": subcategory!.toJson(),
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
        "seller": seller!.toJson(),
        "featured": featured,
        "premium": premium,
        "state": state,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "viewCount": viewCount,
        "id": productId,
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.description,
    this.deletedAt,
    this.imageUrl,
    this.category,
    this.createdAt,
    this.product,
    this.dataId,
  });

  String? id;
  String? name;
  String? description;
  dynamic deletedAt;
  List<String>? imageUrl;
  String? category;
  DateTime? createdAt;
  List<Product>? product;
  String? dataId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        deletedAt: json["deletedAt"],
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        product: json["product"] == null
            ? []
            : List<Product>.from(
                json["product"]!.map((x) => Product.fromJson(x))),
        dataId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "deletedAt": deletedAt,
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
        "category": category,
        "createdAt": createdAt!.toIso8601String(),
        "product": product == null
            ? []
            : List<dynamic>.from(product!.map((x) => x.toJson())),
        "id": dataId,
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
        optionId: Id.fromJson(json["id"]),
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
        others: List<dynamic>.from(json["others"].map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": optionId!.toJson(),
        "values": List<dynamic>.from(values!.map((x) => x.toJson())),
        "others": List<dynamic>.from(others!.map((x) => x)),
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
    this.createdAt,
    this.idId,
  });

  String? id;
  String? subcategory;
  String? inputType;
  String? name;
  dynamic deletedAt;
  bool? deleted;
  DateTime? createdAt;
  String? idId;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["_id"],
        subcategory: json["subcategory"],
        inputType: json["input_type"],
        name: json["name"],
        deletedAt: json["deletedAt"],
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        idId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subcategory": subcategory,
        "input_type": inputType,
        "name": name,
        "deletedAt": deletedAt,
        "deleted": deleted,
        "createdAt": createdAt!.toIso8601String(),
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
    this.createdAt,
  });

  String? id;
  String? option;
  String? value;
  dynamic deletedAt;
  bool? deleted;
  DateTime? createdAt;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["_id"],
        option: json["option"],
        value: json["value"],
        deletedAt: json["deletedAt"],
        deleted: json["deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "option": option,
        "value": value,
        "deletedAt": deletedAt,
        "deleted": deleted,
        "createdAt": createdAt!.toIso8601String(),
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
    this.imageUrl,
    this.isEmailVerified,
    this.createdAt,
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
  String? imageUrl;
  bool? isEmailVerified;
  DateTime? createdAt;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        authType: json["auth_type"],
        allergies: List<dynamic>.from(json["allergies"].map((x) => x)),
        code: json["code"],
        status: json["status"],
        email: json["email"],
        imageUrl: json["imageURL"],
        isEmailVerified: json["isEmailVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "auth_type": authType,
        "allergies": List<dynamic>.from(allergies!.map((x) => x)),
        "code": code,
        "status": status,
        "email": email,
        "imageURL": imageUrl,
        "isEmailVerified": isEmailVerified,
        "createdAt": createdAt!.toIso8601String(),
      };
}

class MetaData {
  MetaData();

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData();

  Map<String, dynamic> toJson() => {};
}
