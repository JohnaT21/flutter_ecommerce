import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/helpers/localization_helper.dart';

class SearchResultCard extends StatelessWidget {
  final Map<String, dynamic> productInfo;

  const SearchResultCard({
    super.key,
    required this.productInfo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              width: double.infinity,
              height: 120,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      productInfo['imagePath'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Product Name
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w),
              child: Text(
                productInfo['name'],
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 20.sp,
                      color: kGreyColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),

            // Rating
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w),
              child: SizedBox(
                width: 1.sw,
                height: 20.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productInfo['rating'],
                  itemBuilder: (BuildContext context, int index) {
                    return Icon(
                      Icons.star,
                      size: 20.h,
                      color: kSecondaryColor,
                    );
                  },
                ),
              ),
            ),

            // Price & Status
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w, right: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price
                  Text(
                    "${productInfo['price']} ETB",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),

                  // Status
                  productInfo['isUsed']
                      ? SizedBox(
                          width: 48.w,
                          height: 25.h,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: kGreyColor,
                              borderRadius: BorderRadius.circular(1000.r),
                            ),
                            child: Center(
                              child: Text(
                                "Used",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 14.sp,
                                      color: kDarkTextColor.withOpacity(0.65),
                                    ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),

            // Divider
            const Divider(
              color: kGreyColor,
            ),

            // Main Action Center
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 4.w, right: 12.w),
              child: Row(
                children: [
                  // Make Offer Button

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ChatPage.routeName);
                    },
                    child: SizedBox(
                      width: 76.w,
                      height: 32.h,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Center(
                          child: Text(
                            getTranslation(context, "offer_text"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Icon(
                      Icons.shopping_cart,
                      color: kGreyColor,
                      size: 28.h,
                    ),
                  ),

                  //
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: SvgPicture.asset(
                      "assets/svgs/heart_outline.svg",
                      fit: BoxFit.fitHeight,
                      height: 26.h,
                      color: kGreyColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
