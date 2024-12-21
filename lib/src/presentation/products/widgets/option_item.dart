import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Padding optionItem({
  required Icon icon,
  required String info,
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15.h),
    child: InkWell(
      onTap: () {},
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 15.w,
          ),
          Text(
            info,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: kDarkTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                fontFamily: 'roboto'),
          )
        ],
      ),
    ),
  );
}
