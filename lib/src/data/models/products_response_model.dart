// To parse this JSON data, do
//
//     final productsResponse = productsResponseFromJson(jsonString);

import 'dart:convert';

ProductsResponse productsResponseFromJson(String str) =>
    ProductsResponse.fromJson(json.decode(str));

String productsResponseToJson(ProductsResponse data) =>
    json.encode(data.toJson());

class ProductsResponse {
  ProductsResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.product,
    required this.metaData,
  });

  bool success;
  int code;
  String message;
  List<Product>? product;
  MetaData metaData;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        product: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
        metaData: MetaData.fromJson(json["metaData"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "": product == null
            ? []
            : List<dynamic>.from(product!.map((x) => x.toJson())),
        "metaData": metaData.toJson(),
      };
}

class Product {
  Product({
    required this.location,
    required this.id,
    required this.name,
    required this.description,
    required this.imagesUrl,
    required this.price,
    this.region,
    required this.subcategory,
    required this.options,
    required this.seller,
    required this.featured,
    required this.premium,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.datumId,
    this.viewCount,
  });

  String location;
  String id;
  String name;
  String description;
  List<dynamic> imagesUrl;
  int price;
  String? region;
  Subcategory subcategory;
  List<Option> options;
  Seller seller;
  bool featured;
  bool premium;
  String state;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String datumId;
  int? viewCount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        location: json["location"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        imagesUrl: List<dynamic>.from(json["imagesURL"].map((x) => x)),
        price: json["price"],
        region: json["region"],
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
        datumId: json["id"],
        viewCount: json["viewCount"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "_id": id,
        "name": name,
        "description": description,
        "imagesURL": List<dynamic>.from(imagesUrl.map((x) => x)),
        "price": price,
        "region": region,
        "subcategory": subcategory.toJson(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "seller": seller.toJson(),
        "featured": featured,
        "premium": premium,
        "state": state,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": datumId,
        "viewCount": viewCount,
      };
}

class Option {
  Option({
    required this.optionId,
    required this.values,
    required this.others,
    required this.id,
  });

  Id optionId;
  List<Value> values;
  List<dynamic> others;
  String id;

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
    required this.id,
    required this.option,
    required this.value,
    this.deletedAt,
    required this.deleted,
  });

  String id;
  String option;
  String value;
  dynamic deletedAt;
  bool deleted;

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
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.authType,
    required this.allergies,
    required this.code,
    required this.status,
    required this.email,
    this.imageUrl,
    required this.isEmailVerified,
  });

  String id;
  String? firstName;
  String? lastName;
  String? phone;
  String? authType;
  List<dynamic> allergies;
  String? code;
  String? status;
  String? email;
  String? imageUrl;
  bool isEmailVerified;

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
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "auth_type": authType,
        "allergies": List<dynamic>.from(allergies.map((x) => x)),
        "code": code,
        "status": status,
        "email": email,
        "imageURL": imageUrl,
        "isEmailVerified": isEmailVerified,
      };
}

class Subcategory {
  Subcategory({
    required this.id,
    required this.name,
    required this.description,
    this.deletedAt,
    required this.imageUrl,
    required this.category,
    required this.subcategoryId,
  });

  String id;
  String name;
  String description;
  dynamic deletedAt;
  List<String> imageUrl;
  String category;
  String subcategoryId;

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
            imageUrl.isEmpty ? [] : List<dynamic>.from(imageUrl.map((x) => x)),
        "category": category,
        "id": subcategoryId,
      };
}

class MetaData {
  MetaData({
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
    required this.filter,
    required this.sort,
  });

  int page;
  int limit;
  int totalPages;
  int totalResults;
  Filter filter;
  String sort;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
        filter: Filter.fromJson(json["filter"]),
        sort: json["sort"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
        "totalResults": totalResults,
        "filter": filter.toJson(),
        "sort": sort,
      };
}

class Filter {
  Filter();

  factory Filter.fromJson(Map<String, dynamic> json) => Filter();

  Map<String, dynamic> toJson() => {};
}
