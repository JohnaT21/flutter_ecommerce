import 'package:ecommerce/src/core/network/network_info.dart';
import 'package:ecommerce/src/data/data_sources/notification_data_source.dart';

import '../../domain/repositories/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NetworkInfo networkInfo;
  final NotificationDataSource notificationDataSource;


  NotificationRepoImpl(this.notificationDataSource, this.networkInfo);

  @override
  Future getNotifications() async {
    if (await networkInfo.isConnected) {
      return notificationDataSource.getNotifications();
    } else {
      return "Please check your connection!";
    }
  }
}