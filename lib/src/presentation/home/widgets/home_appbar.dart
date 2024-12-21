import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/constants.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../notifications/pages/notifications_page.dart';
import '../../products/pages/product_search_delegate.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kBaseColor,
      elevation: 4,
      shadowColor: kSilverColor,
      forceElevated: true,
      collapsedHeight: 132.r,
      expandedHeight: 132.r,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16.w,
          ),
          SvgPicture.asset(
            "assets/svgs/liyu_logo.svg",
            width: 40.h,
            height: 40.h,
          ),
        ],
      ),
      actions: [
        // Padding(
        //   padding: EdgeInsets.fromLTRB(4.w, 0.h, 4.w, 0.h),
        //   child: const Icon(
        //     Icons.shopping_cart,
        //     size: 28,
        //     color: kTertiaryColor,
        //   ),
        // ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, NotificationPage.routeName);
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(4.w, 0.h, 16.w, 0.h),
            child: const Icon(
              Icons.notifications,
              size: 28,
              color: kTertiaryColor,
            ),
          ),
        ),
      ],
      flexibleSpace: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 94.r, 16.w, 0.h),
        child: searchBar(context),
      ),
    );
  }
}

Widget searchBar(BuildContext context) {
  return SizedBox(
    height: 56.h,
    width: 1.sw,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {},
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
              ),
              child: SizedBox(
                height: 56.h,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getTranslation(context, "All Ethiopia"),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: kBaseColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: kBaseColor,
                        size: 24.h,
                      )
                    ]),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: kLightGreyColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5)),
            ),
            child: SizedBox(
              height: 56.h,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 12, top: 4),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: getTranslation(context, "buy_text"),
                ),
                onTap: () {
                  showSearch(
                      context: context, delegate: ProductSearchDelegate());
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
