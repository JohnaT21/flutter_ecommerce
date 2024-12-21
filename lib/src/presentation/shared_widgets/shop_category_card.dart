import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/localization_helper.dart';

class ShopCategoryCard extends StatelessWidget {
  const ShopCategoryCard({
    required this.name,
    required this.image,
    super.key,
  });

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   CategoryPage.routeName,
        // );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${getTranslation(context, "Coming soon!")}...",
            ),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: kBaseColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(color: kGreyColor, offset: Offset(2, 2), blurRadius: 3)
            ]),
        child: SizedBox(
          width: 160.r,
          child: Column(
            children: [
              /// Category image
              SizedBox(
                width: 190.r,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: 160.r,
                    height: 130.r,
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),

              /// Category name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: kDarkTextColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
