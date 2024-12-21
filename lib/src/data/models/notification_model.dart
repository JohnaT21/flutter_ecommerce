class NotificationModel {
  final String title;
  final String description;
  final String? image;
  final DateTime time;
  final bool status;
  NotificationModel({
    required this.time,
    required this.status,
    required this.title,
    required this.description,
    required this.image,
  });
}
