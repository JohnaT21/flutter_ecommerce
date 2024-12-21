// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.notifications,
    required this.metaData,
  });

  bool success;
  int code;
  String message;
  List<Notifications> notifications;
  MetaData metaData;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    notifications: List<Notifications>.from(json["data"].map((x) => Notifications.fromJson(x))),
    metaData: MetaData.fromJson(json["metaData"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(notifications.map((x) => x.toJson())),
    "metaData": metaData.toJson(),
  };
}

class Notifications {
  Notifications({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.body,
    this.type,
    this.image,
  });

  String id;
  String title;
  String description;
  String status;
  DateTime createdAt;
  String? body;
  String? type;
  String? image;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    body: json["body"],
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "body": body,
    "type": type,
    "image": image,
  };
}

class MetaData {
  MetaData();

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
  );

  Map<String, dynamic> toJson() => {
  };
}
