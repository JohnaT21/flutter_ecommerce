// To parse this JSON data, do
//
//     final productCategory = productCategoryFromJson(jsonString);

import 'dart:convert';

ProductCategory productCategoryFromJson(String str) =>
    ProductCategory.fromJson(json.decode(str));

String productCategoryToJson(ProductCategory data) =>
    json.encode(data.toJson());

class ProductCategory {
  ProductCategory({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
    required this.metaData,
  });

  bool success;
  int code;
  String message;
  List<Datum> data;
  MetaData metaData;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        metaData: MetaData.fromJson(json["metaData"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "metaData": metaData.toJson(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.deletedAt,
    required this.deleted,
    required this.subcategory,
    required this.datumId,
  });

  String id;
  String name;
  String description;
  String imageUrl;
  dynamic deletedAt;
  bool deleted;
  List<Subcategory> subcategory;
  String datumId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageURL"],
        deletedAt: json["deletedAt"],
        deleted: json["deleted"],
        subcategory: List<Subcategory>.from(
            json["subcategory"].map((x) => Subcategory.fromJson(x))),
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "imageURL": imageUrl,
        "deletedAt": deletedAt,
        "deleted": deleted,
        "subcategory": List<dynamic>.from(subcategory.map((x) => x.toJson())),
        "id": datumId,
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
    required this.options,
    required this.subcategoryId,
  });

  String id;
  String name;
  String description;
  dynamic deletedAt;
  List<String> imageUrl;
  String category;
  List<OptionElement> options;
  String subcategoryId;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        deletedAt: json["deletedAt"],
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
        category: json["category"],
        options: List<OptionElement>.from(
            json["options"].map((x) => OptionElement.fromJson(x))),
        subcategoryId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "deletedAt": deletedAt,
        "imageURL": List<dynamic>.from(imageUrl.map((x) => x)),
        "category": category,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "id": subcategoryId,
      };
}

class OptionElement {
  OptionElement({
    required this.id,
    required this.subcategory,
    required this.inputType,
    required this.name,
    this.deletedAt,
    required this.deleted,
    required this.values,
    required this.suboptions,
    required this.optionId,
  });

  String id;
  String subcategory;
  String inputType;
  String name;
  dynamic deletedAt;
  bool deleted;
  List<Values> values;
  List<dynamic> suboptions;
  String optionId;

  factory OptionElement.fromJson(Map<String, dynamic> json) => OptionElement(
        id: json["_id"],
        subcategory: json["subcategory"],
        inputType: json["input_type"],
        name: json["name"],
        deletedAt: json["deletedAt"],
        deleted: json["deleted"],
        values:
            List<Values>.from(json["values"].map((x) => Values.fromJson(x))),
        suboptions: List<dynamic>.from(json["suboptions"].map((x) => x)),
        optionId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subcategory": subcategory,
        "input_type": inputType,
        "name": name,
        "deletedAt": deletedAt,
        "deleted": deleted,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
        "suboptions": List<dynamic>.from(suboptions.map((x) => x)),
        "id": optionId,
      };
}

class Values {
  String id;
  String option;
  String value;
  dynamic deletedAt;
  bool deleted;

  Values(
      {required this.id,
      required this.option,
      required this.value,
      this.deletedAt,
      required this.deleted});

  factory Values.fromJson(Map<String, dynamic> json) => Values(
        id: json['_id'],
        option: json['option'],
        value: json['value'],
        deletedAt: json['deletedAt'],
        deleted: json['deleted'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['option'] = option;
    data['value'] = value;
    data['deletedAt'] = deletedAt;
    data['deleted'] = deleted;
    return data;
  }
}

class MetaData {
  MetaData();

  MetaData.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}


// class Value {
//     Value({
//         required this.id,
//         required this.option,
//         required this.value,
//         this.deletedAt,
//         required this.deleted,
//     });

//     String id;
//     OptionEnum option;
//     String value;
//     dynamic deletedAt;
//     bool deleted;

//     factory Value.fromJson(Map<String, dynamic> json) => Value(
//         id: json["_id"],
//         option: optionEnumValues.map[json["option"]]!,
//         value: json["value"],
//         deletedAt: json["deletedAt"],
//         deleted: json["deleted"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "option": optionEnumValues.reverse[option],
//         "value": value,
//         "deletedAt": deletedAt,
//         "deleted": deleted,
//     };
// }

// enum OptionEnum { THE_63_F7486_DDA8_CC33_DE0_E0_C497, THE_63_F7486_DDA8_CC33_DE0_E0_C498, THE_63_F7486_DDA8_CC33_DE0_E0_C499, THE_63_F7486_DDA8_CC33_DE0_E0_C49_A }

// final optionEnumValues = EnumValues({
//     "63f7486dda8cc33de0e0c497": OptionEnum.THE_63_F7486_DDA8_CC33_DE0_E0_C497,
//     "63f7486dda8cc33de0e0c498": OptionEnum.THE_63_F7486_DDA8_CC33_DE0_E0_C498,
//     "63f7486dda8cc33de0e0c499": OptionEnum.THE_63_F7486_DDA8_CC33_DE0_E0_C499,
//     "63f7486dda8cc33de0e0c49a": OptionEnum.THE_63_F7486_DDA8_CC33_DE0_E0_C49_A
// });

// class MetaData {
//     MetaData();

//     factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
//     );

//     Map<String, dynamic> toJson() => {
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }







// class ProductCategory {
// 	bool success;
// 	int code;
// 	String message;
// 	List<Data> data;
// 	MetaData metaData;

// 	ProductCategory({this.success, this.code, this.message, this.data, this.metaData});

// 	ProductCategory.fromJson(Map<String, dynamic> json) {
// 		success = json['success'];
// 		code = json['code'];
// 		message = json['message'];
// 		if (json['data'] != null) {
// 			data = new List<Data>();
// 			json['data'].forEach((v) { data.add(new Data.fromJson(v)); });
// 		}
// 		metaData = json['metaData'] != null ? new MetaData.fromJson(json['metaData']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['success'] = this.success;
// 		data['code'] = this.code;
// 		data['message'] = this.message;
// 		if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
// 		if (this.metaData != null) {
//       data['metaData'] = this.metaData.toJson();
//     }
// 		return data;
// 	}
// }

// class Data {
// 	String sId;
// 	String name;
// 	String description;
// 	String imageURL;
// 	Null deletedAt;
// 	bool deleted;
// 	List<Subcategory> subcategory;
// 	String id;

// 	Data({this.sId, this.name, this.description, this.imageURL, this.deletedAt, this.deleted, this.subcategory, this.id});

// 	Data.fromJson(Map<String, dynamic> json) {
// 		sId = json['_id'];
// 		name = json['name'];
// 		description = json['description'];
// 		imageURL = json['imageURL'];
// 		deletedAt = json['deletedAt'];
// 		deleted = json['deleted'];
// 		if (json['subcategory'] != null) {
// 			subcategory = new List<Subcategory>();
// 			json['subcategory'].forEach((v) { subcategory.add(new Subcategory.fromJson(v)); });
// 		}
// 		id = json['id'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['_id'] = this.sId;
// 		data['name'] = this.name;
// 		data['description'] = this.description;
// 		data['imageURL'] = this.imageURL;
// 		data['deletedAt'] = this.deletedAt;
// 		data['deleted'] = this.deleted;
// 		if (this.subcategory != null) {
//       data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
//     }
// 		data['id'] = this.id;
// 		return data;
// 	}
// }

// class Subcategory {
// 	String sId;
// 	String name;
// 	String description;
// 	Null deletedAt;
// 	List<String> imageURL;
// 	String category;
// 	List<Options> options;
// 	String id;

// 	Subcategory({this.sId, this.name, this.description, this.deletedAt, this.imageURL, this.category, this.options, this.id});

// 	Subcategory.fromJson(Map<String, dynamic> json) {
// 		sId = json['_id'];
// 		name = json['name'];
// 		description = json['description'];
// 		deletedAt = json['deletedAt'];
// 		imageURL = json['imageURL'].cast<String>();
// 		category = json['category'];
// 		if (json['options'] != null) {
// 			options = new List<Options>();
// 			json['options'].forEach((v) { options.add(new Options.fromJson(v)); });
// 		}
// 		id = json['id'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['_id'] = this.sId;
// 		data['name'] = this.name;
// 		data['description'] = this.description;
// 		data['deletedAt'] = this.deletedAt;
// 		data['imageURL'] = this.imageURL;
// 		data['category'] = this.category;
// 		if (this.options != null) {
//       data['options'] = this.options.map((v) => v.toJson()).toList();
//     }
// 		data['id'] = this.id;
// 		return data;
// 	}
// }

// class Options {
// 	String sId;
// 	String subcategory;
// 	String inputType;
// 	String name;
// 	Null deletedAt;
// 	bool deleted;
// 	List<Values> values;
// 	List<Null> suboptions;
// 	String id;

// 	Options({this.sId, this.subcategory, this.inputType, this.name, this.deletedAt, this.deleted, this.values, this.suboptions, this.id});

// 	Options.fromJson(Map<String, dynamic> json) {
// 		sId = json['_id'];
// 		subcategory = json['subcategory'];
// 		inputType = json['input_type'];
// 		name = json['name'];
// 		deletedAt = json['deletedAt'];
// 		deleted = json['deleted'];
// 		if (json['values'] != null) {
// 			values = new List<Values>();
// 			json['values'].forEach((v) { values.add(new Values.fromJson(v)); });
// 		}
// 		if (json['suboptions'] != null) {
// 			suboptions = new List<Null>();
// 			json['suboptions'].forEach((v) { suboptions.add(new Null.fromJson(v)); });
// 		}
// 		id = json['id'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['_id'] = this.sId;
// 		data['subcategory'] = this.subcategory;
// 		data['input_type'] = this.inputType;
// 		data['name'] = this.name;
// 		data['deletedAt'] = this.deletedAt;
// 		data['deleted'] = this.deleted;
// 		if (this.values != null) {
//       data['values'] = this.values.map((v) => v.toJson()).toList();
//     }
// 		if (this.suboptions != null) {
//       data['suboptions'] = this.suboptions.map((v) => v.toJson()).toList();
//     }
// 		data['id'] = this.id;
// 		return data;
// 	}
// }
