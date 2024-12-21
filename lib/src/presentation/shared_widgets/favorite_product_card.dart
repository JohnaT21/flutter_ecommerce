import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/presentation/product_detail/bloc/product_detail_bloc.dart';
import 'package:ecommerce/src/presentation/product_detail/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/favorite_model.dart';

class FavoriteProductCard extends StatelessWidget {
  const FavoriteProductCard({super.key, required this.product});
  final FavProduct product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<ProductDetailBloc>(context)
              .add(GetProductsDetail(productId: product.id!));
          Navigator.pushNamed(
            context,
            ProductDetailPage.routeName,
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: kBaseColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                    color: kGreyColor, offset: Offset(2, 2), blurRadius: 3)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Product image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.imagesUrl!.isNotEmpty
                      ? '$BASE_API_URL_IMAGE/${product.imagesUrl![0]}'
                      : '',
                  fit: BoxFit.cover,
                  height: 200.h,
                  width: double.infinity,
                  errorWidget: (context, error, _) => const Center(
                    child: Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),

              /// Title and Desc
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Text(
                  product.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: kDarkGreyColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                ),
              ),

              /// Price and usage Status
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${product.price} ETB",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: kDarkTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: kLightGreyColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Text(
                          getProductState(product),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: kDarkGreyColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
              //   child: const Divider(
              //     thickness: 1,
              //   ),
              // ),

              /// Bottom row
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       RoundedButton(
              //         onPressed: () {
              //           Navigator.pushNamed(context, ChatPage.routeName);
              //         },
              //         child: Text(getTranslation(context, "offer_text")),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  String getProductState(product) {
    String condition = '';
    if (product.options != null && product.options!.isNotEmpty) {
      product.options!.forEach((option) {
        if (option.optionId!.name == "Condition") {
          condition = option.values![0].value!;
        } else {
          condition = "UNKNOWN";
        }
      });
    }
    return condition;
  }
}
