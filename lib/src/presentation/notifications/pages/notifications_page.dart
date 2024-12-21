import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/data/models/notification_model.dart';
import 'package:ecommerce/src/data/models/notification_response_model.dart';
import 'package:ecommerce/src/presentation/notifications/widget/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../core/helpers/localization_helper.dart';
import '../bloc/notification_bloc.dart';

List<NotificationModel> notifications = [
  NotificationModel(
    time: DateTime.now(),
    status: true,
    title: 'Order Completed',
    description:
        'It seems you have finished program limit for today, it will be available tomorrow',
    image: null,
  ),
  NotificationModel(
    time: DateTime(2003, 6, 1, 5, 1),
    status: false,
    title: 'Order Completed',
    description:
        'It seems you have finished program limit for today, it will be available tomorrow',
    image: null,
  ),
  NotificationModel(
    time: DateTime(2003, 6, 1, 5, 1),
    status: false,
    title: 'Order Completed',
    description:
        'It seems you have finished program limit for today, it will be available tomorrow',
    image: null,
  ),
];

class NotificationPage extends StatelessWidget {
  static const String routeName = "/notification_page";
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kBaseColor,
          automaticallyImplyLeading: false,
          title: Text(
            getTranslation(context, "notifcation_text"),
            style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: kDarkTextColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded) {
            return GroupedListView<Notifications, DateTime>(
              elements: state.notifications,
              groupBy: (element) => element.createdAt,
              groupComparator: (value1, value2) => value1.compareTo(value1),
              itemComparator: (item1, item2) =>
                  item1.createdAt.compareTo(item2.createdAt),
              useStickyGroupSeparators: true, // optional
              floatingHeader: true, // optional
              order: GroupedListOrder.DESC,
              groupSeparatorBuilder: (DateTime value) => Container(
                width: MediaQuery.of(context).size.width,
                color: kGreyColor,
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 10.h,
                  left: 40.w,
                ),
                child: Text('${value.year}/${value.month}/${value.day}'),
              ),
              itemBuilder: (context, notification) {
                return NotificationTile(
                  notification: notification,
                );
              },
            );
          } else if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotificationError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
