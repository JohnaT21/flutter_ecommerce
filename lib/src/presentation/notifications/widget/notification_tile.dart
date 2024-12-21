import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/data/models/notification_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/localization_helper.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification});
  final Notifications notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.w,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: kFadedBackgroundColor,
                backgroundImage: AssetImage(
                  'assets/images/notification_icon.png',
                ),
              ),
              title: Text(notification.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 19.sp,
                      fontFamily: 'roboto',
                      color: notification.status == 'Active'
                          ? kPrimaryColor
                          : kDarkTextColor)),
              subtitle: Text(
                notification.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 14.sp, fontFamily: 'roboto'),
              ),
              trailing:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                notification.status == 'Active'
                    ? const CircleAvatar(
                        radius: 5,
                      )
                    : const SizedBox(),
                Text(
                    '${notification.createdAt.minute} ${getTranslation(context, "min")}')
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 90.w,
            ),
            child: const Divider(),
          )
        ],
      ),
    );
  }
}
