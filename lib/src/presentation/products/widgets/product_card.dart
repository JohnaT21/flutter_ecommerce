import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/products/widgets/bottom_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../config/env.dart';
import '../../../data/models/products_response_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    Logger().d(product.toJson());
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Card(
          elevation: 2,
          child: SizedBox(
            height: 110.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 110.h,
                //   width: 130.w,
                //   child: Image.asset(
                //     'assets/images/phone.png',
                //     fit: BoxFit.fill,
                //   ),
                // ),
                CachedNetworkImage(
                  imageUrl: product.imagesUrl.isNotEmpty
                      ? '$BASE_API_URL_IMAGE${product.imagesUrl[0]}'
                      : '',
                  fit: BoxFit.fill,
                  height: 110.h,
                  width: 130.w,
                  errorWidget: (context, value, data) => Image.asset(
                    'assets/images/liyu_logo.png',
                    fit: BoxFit.fill,
                    height: 110.h,
                    width: 130.w,
                  ),
                  placeholder: (context, value) => Image.asset(
                    'assets/images/liyu_logo.png',
                    fit: BoxFit.fill,
                    height: 110.h,
                    width: 130.w,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 20.sp,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.bold),
                    ),
                    RatingBar(
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.orange),
                          half: const Icon(
                            Icons.star_half,
                            color: Colors.orange,
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Colors.orange,
                          )),
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.sp,
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Text(
                      '${product.price} ETB',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: kDarkTextColor,
                          fontSize: 20.sp,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        viewsWidget(view: product.viewCount),
                        SizedBox(
                          width: 8.w,
                        ),
                        shareWidget(),
                      ],
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
                // IconButton(
                //   onPressed: (() {}),
                //   icon: const Icon(
                //     Icons.more_vert,
                //     size: 36,
                //     color: kDarkGreyColor,
                //   ),
                // )
              ],
            ),
          )),
    );
  }
}
