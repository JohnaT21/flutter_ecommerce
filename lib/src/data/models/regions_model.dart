// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionModel regionModelFromJson(String str) => RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
    RegionModel({
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

    factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
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
        required this.subCitys,
        required this.deleted,
    });

    String id;
    String name;
    List<String> subCitys;
    bool deleted;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        subCitys: List<String>.from(json["subCitys"].map((x) => x)),
        deleted: json["deleted"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "subCitys": List<dynamic>.from(subCitys.map((x) => x)),
        "deleted": deleted,
    };
}

class MetaData {
    MetaData();

    factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    );

    Map<String, dynamic> toJson() => {
    };
}
