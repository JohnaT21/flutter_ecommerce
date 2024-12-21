import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/presentation/favorite/bloc/favorite_bloc.dart';
import 'package:ecommerce/src/presentation/product_detail/bloc/product_detail_bloc.dart';
import 'package:ecommerce/src/presentation/product_detail/pages/product_detail_page.dart';
import 'package:ecommerce/src/presentation/shared_widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../core/helpers/localization_helper.dart';
import '../../data/models/products_response_model.dart';
import '../../di/injector.dart';
import '../chat/pages/chat_page.dart';

class FeaturedProductCard extends StatefulWidget {
  const FeaturedProductCard({super.key, required this.product});
  final Product product;

  @override
  State<StatefulWidget> createState() => _FeaturedProductCardState();
}

class _FeaturedProductCardState extends State<FeaturedProductCard> {
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductDetailBloc>(context)
            .add(GetProductsDetail(productId: widget.product.id));
        Navigator.pushNamed(context, ProductDetailPage.routeName);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: kBaseColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(color: kGreyColor, offset: Offset(2, 2), blurRadius: 3)
            ]),
        child: SizedBox(
          width: 190.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Product image
              SizedBox(
                width: 190.r,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.imagesUrl.isNotEmpty
                        ? '$BASE_API_URL_IMAGE${widget.product.imagesUrl[0]}'
                        : '',
                    fit: BoxFit.cover,
                    width: 190.r,
                    height: 130.r,
                    errorWidget: (context, value, data) => Image.asset(
                      'assets/images/liyu_logo.png',
                      fit: BoxFit.cover,
                      width: 190.r,
                      height: 130.r,
                    ),
                    placeholder: (context, value) => Image.asset(
                      'assets/images/liyu_logo.png',
                      fit: BoxFit.cover,
                      width: 190.r,
                      height: 130.r,
                    ),
                  ),
                ),
              ),

              /// Title and Desc
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Text(
                  widget.product.name,
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
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: SizedBox(
                  width: 190.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.product.price} ETB",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: kDarkTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                            ),
                      ),
                      // DecoratedBox(
                      //   decoration: BoxDecoration(
                      //       color: kLightGreyColor,
                      //       borderRadius: BorderRadius.circular(20)),
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 8.w, vertical: 4.h),
                      //     child: Text(
                      //       "",
                      //       maxLines: 2,
                      //       overflow: TextOverflow.clip,
                      //       style:
                      //           Theme.of(context).textTheme.headline6?.copyWith(
                      //                 color: kDarkGreyColor,
                      //                 fontSize: 13.sp,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: 190.r,
                child: const Divider(
                  thickness: 1,
                ),
              ),

              /// Bottom row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: SizedBox(
                  width: 190.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: RoundedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ChatPage.routeName);
                          },
                          child: Text(getTranslation(context, "offer_text")),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Logger().d("message fav......");
                            setState(() {
                              fav = !fav;
                            });
                            sl<FavoriteBloc>().add(
                                AddToFavoriteEvent(product: widget.product.id));
                            sl<FavoriteBloc>().add(GetAllFavoriteEvent());
                          },
                          icon: fav
                              ? const Icon(
                                  Icons.favorite_sharp,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_outline,
                                )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
