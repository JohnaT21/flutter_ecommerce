import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/products/widgets/option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/localization_helper.dart';

class ProductOptionPage extends StatelessWidget {
  static const routeName = "/product_option_page";
  const ProductOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kGreyTextColor,
        body: Stack(children: [
          Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                  decoration: BoxDecoration(
                    color: kBaseColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0.r),
                      topLeft: Radius.circular(15.0.r),
                    ),
                  ),
                  padding: EdgeInsets.all(16.w),
                  height: 300.h,
                  child: Column(children: [
                    optionItem(
                        icon: Icon(
                          Icons.edit,
                          size: 35.sp,
                        ),
                        info: getTranslation(context, "Edit Item"),
                        context: context),
                    const Divider(),
                    optionItem(
                        icon: Icon(
                          Icons.remove_circle,
                          size: 35.sp,
                        ),
                        info: getTranslation(context,"remove_text"),
                        context: context),
                    const Divider(),
                    optionItem(
                        icon: Icon(
                          Icons.not_accessible_outlined,
                          size: 35.sp,
                        ),
                        info: getTranslation(context, "sold_text"),
                        context: context),
                    const Divider()
                  ])))
        ],),);
  }
}
