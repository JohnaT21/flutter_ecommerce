import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageChatView extends StatelessWidget {
  const ImageChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: SizedBox(
        width: 120.h,
        height: 100.h,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/laughing_emoji.png"),
            ),
          ),
        ),
      ),
    );
  }
}
