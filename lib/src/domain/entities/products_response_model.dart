class ProductsResponse {
  ProductsResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
    required this.metaData,
  });

  bool success;
  int code;
  String message;
  List<Product> data;
  MetaData metaData;
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imagesUrl,
    required this.price,
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
  });

  String id;
  String name;
  String description;
  List<dynamic>? imagesUrl;
  int price;
  Subcategory subcategory;
  List<Option> options;
  String seller;
  bool featured;
  bool premium;
  String state;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String datumId;
}

class Option {
  Option({
    required this.optionId,
    required this.values,
    required this.id,
  });

  IdClass optionId;
  List<Value> values;
  String id;
}

class IdClass {
  IdClass({
    required this.subcategory,
    required this.name,
    this.deletedAt,
    required this.deleted,
    required this.id,
  });

  String subcategory;
  String name;
  dynamic deletedAt;
  bool deleted;
  String id;
}

class Value {
  Value({
    required this.option,
    required this.value,
    this.deletedAt,
    required this.deleted,
    required this.id,
  });

  String option;
  String value;
  dynamic deletedAt;
  bool deleted;
  String id;
}

class Subcategory {
  Subcategory({
    required this.name,
    required this.description,
    this.deletedAt,
    required this.imageUrl,
    required this.category,
    required this.id,
  });

  String name;
  String description;
  dynamic deletedAt;
  List<String>? imageUrl;
  String category;
  String id;
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
}

class Filter {
  Filter();
}
