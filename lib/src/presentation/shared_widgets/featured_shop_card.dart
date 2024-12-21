import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/data/models/shop_model.dart';
import 'package:ecommerce/src/presentation/shared_widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/localization_helper.dart';

class FeaturedShopCard extends StatelessWidget {
  const FeaturedShopCard({super.key, required this.shop});
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190.r,
      child: Column(
        children: [
          /// Shop image
          SizedBox(
            width: 160.r,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                "assets/images/shop.jpg",
                fit: BoxFit.cover,
                width: 160.r,
                height: 160.r,
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),

          /// Shop Name
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            child: Text(
              shop.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: kDarkGreyColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
            ),
          ),

          /// Shop Item count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              width: 190.r,
              child: Text(
                shop.phoneNumber!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kDarkTextColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
              ),
            ),
          ),

          /// Bottom row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: RoundedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${getTranslation(context, "Coming soon!")}...",
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Text(getTranslation(context, "view_product_text")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
