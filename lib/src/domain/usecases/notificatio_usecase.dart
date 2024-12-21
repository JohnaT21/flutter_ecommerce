import '../../data/models/notification_response_model.dart';
import '../repositories/notification_repo.dart';

class NotificationUseCase {
  final NotificationRepo notificationRepo;

  NotificationUseCase({required this.notificationRepo});

  Future<NotificationResponse> getNotifications() async{
    return await notificationRepo.getNotifications();
  }
}