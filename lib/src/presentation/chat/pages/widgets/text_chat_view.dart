import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextChatView extends StatelessWidget {
  final String message;
  final String time;
  final String status;
  const TextChatView({
    super.key,
    required this.message,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 28.h),
      child: SizedBox(
        width: 200.w,
        height: 95.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: status == "incoming"
                ? kPrimaryColor
                : kGreyColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 16.h,
              left: 16.w,
              right: 16.w,
              bottom: 4.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 17.sp,
                          color: kBaseColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),

                SizedBox(
                  height: 6.h,
                ),

                // Time
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12.sp,
                          color: kBaseColor.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
