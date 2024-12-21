import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          const Icon(
            Icons.notifications,
            color: kDarkTextColor,
          ),
          Positioned(
            // left: 0,
            top: 0,
            right: 0,
            child: CircleAvatar(
                radius: 7.r,
                backgroundColor: kBaseColor,
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: kPrimaryColor,
                )),
          ),
        ],
      ),
    );
  }
}
