import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget filterContainer({
  required String name,
  required int index,
  required Function select,
  required List<String>? list,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () => select(),
    child: Container(
      decoration: BoxDecoration(
        color: !list!.contains(name) ? Colors.white : const Color(0xffF2F6FF),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0.r),
        ),
        border: Border.all(
            color:
                !list.contains(name) ? const Color(0xffC7C7C7) : kPrimaryColor,
            width: 2),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
      child: Center(
          child: Text(
        name,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 18.sp, color: kDarkTextColor, fontFamily: 'roboto'),
      )),
    ),
  );
}
