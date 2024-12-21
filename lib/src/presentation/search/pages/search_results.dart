import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/search/widgets/search_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultsPage extends StatelessWidget {
  static const String routeName = "/search_results";
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = List.filled(
      8,
      {
        "id": 1,
        "name": "Samsung A51",
        "imagePath": "assets/images/phone.png",
        "rating": 4,
        "price": 19450,
        "isUsed": true,
      },
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: true,
        backgroundColor: kBaseColor,
        title: Text(
          "Products",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 24.sp,
                letterSpacing: 0.26,
                fontWeight: FontWeight.w600,
                color: kDarkTextColor,
              ),
        ),
      ),
      body: SizedBox(
        width: 1.sw,
        height: (1.sh - 70.h),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: kFadedBackgroundColor,
          ),
          child: GridView.builder(
            itemCount: products.length, //widget.artist.albums!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 190 / 300,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 20.h,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
              vertical: 25.h,
            ),
            itemBuilder: (context, index) {
              return SearchResultCard(
                productInfo: products[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
