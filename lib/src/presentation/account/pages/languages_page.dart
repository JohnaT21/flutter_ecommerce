import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/constants.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../presentation/shared_widgets/language_selector.dart';

class LanguagesPage extends StatelessWidget {
  static const String routeName = "/languages";
  const LanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kDarkTextColor,
        ),
        toolbarHeight: 70.h,
        backgroundColor: kBaseColor,
        elevation: 0.95,
        title: Text(
          getTranslation(context, "Languages"),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: kDarkTextColor,
                letterSpacing: 0.2,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: kFadedBackgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 2.h),
            child: const LanguageSelector(
              languages: ["English", "Amharic"],
            ),
          ),
        ),
      ),
    );
  }
}
