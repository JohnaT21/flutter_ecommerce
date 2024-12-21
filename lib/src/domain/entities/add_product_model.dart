// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) =>
    AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) =>
    json.encode(data.toJson());

class AddProductModel {
  AddProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.subcategory,
    required this.options,
    required this.region,
    required this.location,
  });
  String name;
  String region;
  String location;
  String description;
  int price;
  String subcategory;
  List<Option> options;

  factory AddProductModel.fromJson(Map<String, dynamic> json) =>
      AddProductModel(
        name: json["name"],
        description: json["description"],
        location: json["location"],
        region: json["region"],
        price: json["price"],
        subcategory: json["subcategory"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "location": location,
        "region": region,
        "price": price,
        "subcategory": subcategory,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    required this.id,
    required this.values,
  });

  String id;
  List<String> values;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        values: List<String>.from(json["values"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "values": List<dynamic>.from(values.map((x) => x)),
      };
}
