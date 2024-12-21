import 'package:ecommerce/src/presentation/notifications/pages/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants.dart';

// class DefaultAppBar extends StatelessWidget {
//   const DefaultAppBar({required this.title, super.key});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       backgroundColor: kBaseColor,
//       elevation: 4,
//       shadowColor: kSilverColor,
//       forceElevated: true,
//       automaticallyImplyLeading: false,
//       title: Text(
//           title,
//         style: const TextStyle(color: kDarkTextColor),
//       ),
// actions: [
//   Padding(
//     padding: EdgeInsets.fromLTRB(4.w, 0.h, 4.w, 0.h),
//     child: const Icon(
//       Icons.shopping_cart,
//       size: 28,
//       color: kTertiaryColor,
//     ),
//   ),
//   Padding(
//     padding: EdgeInsets.fromLTRB(4.w, 0.h, 16.w, 0.h),
//     child: const Icon(
//       Icons.notifications,
//       size: 28,
//       color: kTertiaryColor,
//     ),
//   ),
// ],
//     );
//   }
// }

List<Widget> commonActions(BuildContext context) {
  return [
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
  ];
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    required this.title,
    super.key,
    required this.hasLeading,
    required this.actions,
  });
  final bool hasLeading;
  final List<Widget>? actions;

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kBaseColor,
      elevation: 4,
      shadowColor: kSilverColor,
      forceElevated: true,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(color: kDarkTextColor),
      ),
      leading: hasLeading
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kDarkTextColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
    );
  }
}
