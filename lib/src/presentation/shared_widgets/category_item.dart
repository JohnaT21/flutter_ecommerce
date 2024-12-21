import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.image,
    required this.name,
    super.key,
  });
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: kSilverColor,
          ),
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: SizedBox(
                height: 60.r,
                width: 60.r,
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  errorWidget: (context, value, data) => Image.asset(
                    'assets/images/liyu_logo.png',
                    fit: BoxFit.cover,
                    width: 60.r,
                    height: 60.r,
                  ),
                  placeholder: (context, value) => Image.asset(
                    'assets/images/liyu_logo.png',
                    fit: BoxFit.cover,
                    width: 60.r,
                    height: 60.r,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
        )
      ],
    );
  }
}
