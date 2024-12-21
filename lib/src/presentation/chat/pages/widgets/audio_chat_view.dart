import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioChatView extends StatelessWidget {
  final String status;
  final String time;
  const AudioChatView({
    super.key,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 28.h),
      child: SizedBox(
        width: 200.w,
        height: 90.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: status == "incoming"
                ? kPrimaryColor
                : kGreyColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding:
                EdgeInsets.only(top: 8.h, left: 8.w, right: 8.w, bottom: 4.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.play_circle_fill_outlined,
                        size: 48.h,
                        color: kDarkTextColor.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 120.w,
                          height: 20.h,
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                opacity: 0.55,
                                image: AssetImage(
                                  "assets/images/wave_icon.png",
                                ),
                                repeat: ImageRepeat.repeat,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
                          color: kDarkTextColor.withOpacity(0.5),
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
