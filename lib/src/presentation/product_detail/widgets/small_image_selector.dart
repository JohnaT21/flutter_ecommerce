import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallImageSelector extends StatelessWidget {
  const SmallImageSelector({
    required this.imageUrl,
    required this.onPressed,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(right: 8.w, top: 6.h),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isSelected ? kPrimaryColor : kGreyColor,
              width: 4,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: 80.r,
                height: 40.r,
                errorWidget: (context, value, data) => Image.asset(
                  'assets/images/liyu_logo.png',
                  fit: BoxFit.cover,
                  width: 50.w,
                  height: 50.h,
                ),
                placeholder: (context, value) => Image.asset(
                  'assets/images/liyu_logo.png',
                  fit: BoxFit.cover,
                  width: 50.w,
                  height: 50.h,
                ),
              ),
              // child: CachedNetworkImage(
              //   imageUrl: imageUrl,
              //   fit: BoxFit.cover,
              //   width: 80.r,
              //   height: 40.r,
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
