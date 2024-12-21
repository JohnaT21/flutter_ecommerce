import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleCategoryItem extends StatelessWidget {
  final String name;
  final String imageURL;
  final String description;
  const SingleCategoryItem(
      {Key? key,
      required this.name,
      required this.imageURL,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: imageURL,
            height: 50.h,
            width: 50.w,
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
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 5.h),
              Text(
                description,
                style: TextStyle(color: kLightDarkColor, fontSize: 15.sp),
              ),
            ],
          )
        ],
      ),
    );
  }
}
