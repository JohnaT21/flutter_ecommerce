// To parse this JSON data, do
//
//     final productDetailResponse = productDetailResponseFromJson(jsonString);

import 'dart:convert';

ProductDetailResponse productDetailResponseFromJson(String str) =>
    ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) =>
    json.encode(data.toJson());

class ProductDetailResponse {
  bool success;
  int code;
  String message;
  Data data;
  MetaData metaData;

  ProductDetailResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
    required this.metaData,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponse(
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
  Product product;
  List<Product> relatedProducts;

  Data({
    required this.product,
    required this.relatedProducts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: Product.fromJson(json["product"]),
        relatedProducts: List<Product>.from(
            json["relatedProducts"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "relatedProducts":
            List<dynamic>.from(relatedProducts.map((x) => x.toJson())),
      };
}

class Product {
  String id;
  String? name;
  String? description;
  List<String>? imagesUrl;
  int? price;
  String? region;
  String? location;
  Subcategory subcategory;
  List<Option> options;
  Seller seller;
  bool featured;
  bool premium;
  String? state;
  DateTime createdAt;
  DateTime updatedAt;
  int? v;
  int? viewCount;
  String? productId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imagesUrl,
    required this.price,
    required this.region,
    required this.location,
    required this.subcategory,
    required this.options,
    required this.seller,
    required this.featured,
    required this.premium,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.viewCount,
    required this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        imagesUrl: List<String>.from(json["imagesURL"].map((x) => x)),
        price: json["price"],
        region: json["region"],
        location: json["location"],
        subcategory: Subcategory.fromJson(json["subcategory"]),
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
        "region": region,
        "location": location,
        "subcategory": subcategory.toJson(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "seller": seller.toJson(),
        "featured": featured,
        "premium": premium,
        "state": state,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "viewCount": viewCount,
        "id": productId,
      };
}

class Option {
  Id optionId;
  List<Value> values;
  List<dynamic> others;
  String id;

  Option({
    required this.optionId,
    required this.values,
    required this.others,
    required this.id,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionId: Id.fromJson(json["id"]),
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
        others: List<dynamic>.from(json["others"].map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": optionId.toJson(),
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
        "others": List<dynamic>.from(others.map((x) => x)),
        "_id": id,
      };
}

class Id {
  String id;
  String? subcategory;
  String? inputType;
  String? name;
  dynamic deletedAt;
  bool deleted;
  DateTime createdAt;
  String? idId;

  Id({
    required this.id,
    required this.subcategory,
    required this.inputType,
    required this.name,
    this.deletedAt,
    required this.deleted,
    required this.createdAt,
    required this.idId,
  });

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
        "createdAt": createdAt.toIso8601String(),
        "id": idId,
      };
}

class Value {
  String id;
  String? option;
  String? value;
  dynamic deletedAt;
  bool deleted;
  DateTime createdAt;

  Value({
    required this.id,
    required this.option,
    required this.value,
    this.deletedAt,
    required this.deleted,
    required this.createdAt,
  });

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
        "createdAt": createdAt.toIso8601String(),
      };
}

class Seller {
  String id;
  String? firstName;
  String? lastName;
  String? authType;
  List<dynamic> allergies;
  String? status;
  String? email;
  String? imageUrl;
  bool isEmailVerified;
  DateTime createdAt;
  dynamic deviceToken;

  Seller({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.authType,
    required this.allergies,
    required this.status,
    required this.email,
    required this.imageUrl,
    required this.isEmailVerified,
    required this.createdAt,
    this.deviceToken,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        authType: json["auth_type"],
        allergies: List<dynamic>.from(json["allergies"].map((x) => x)),
        status: json["status"],
        email: json["email"],
        imageUrl: json["imageURL"],
        isEmailVerified: json["isEmailVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "auth_type": authType,
        "allergies": List<dynamic>.from(allergies.map((x) => x)),
        "status": status,
        "email": email,
        "imageURL": imageUrl,
        "isEmailVerified": isEmailVerified,
        "createdAt": createdAt.toIso8601String(),
        "device_token": deviceToken,
      };
}

class Subcategory {
  String id;
  String? name;
  String? description;
  dynamic deletedAt;
  List<String>? imageUrl;
  String? category;
  DateTime createdAt;
  String? subcategoryId;

  Subcategory({
    required this.id,
    required this.name,
    required this.description,
    this.deletedAt,
    required this.imageUrl,
    required this.category,
    required this.createdAt,
    required this.subcategoryId,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        deletedAt: json["deletedAt"],
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
        category: json["category"],
        createdAt: DateTime.parse(json["createdAt"]),
        subcategoryId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "deletedAt": deletedAt,
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
        "category": category,
        "createdAt": createdAt.toIso8601String(),
        "id": subcategoryId,
      };
}

class MetaData {
  MetaData();

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData();

  Map<String, dynamic> toJson() => {};
}
