import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/core/helpers/snack_bar_service.dart';
import 'package:ecommerce/src/data/models/product_detail_model.dart';
import 'package:ecommerce/src/presentation/product_detail/bloc/product_detail_bloc.dart';
import 'package:ecommerce/src/presentation/product_detail/widgets/small_image_selector.dart';
import 'package:ecommerce/src/presentation/shared_widgets/default_app_bar.dart';
import 'package:ecommerce/src/presentation/shared_widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../core/helpers/localization_helper.dart';
import '../../products/bloc/product_bloc.dart';
import '../../shared_widgets/featured_product_card.dart';
import '../../shared_widgets/rounded_outlined_button.dart';

class ProductDetailPage extends StatefulWidget {
  static const routeName = "/product_detail_page";

  const ProductDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String displayedImage = '';
  final List<String> images = [
    "https://previews.123rf.com/images/mathier/mathier1905/mathier190500002/134557216-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProductDetailBloc, ProductDetailState>(
            listener: (context, state) {
      Logger().d(state);
    }, builder: (context, state) {
      if (state is ProductDetailLoaded) {
        final Product product = state.detailResponse.data.product;
        return CustomScrollView(
          slivers: [
            DefaultAppBar(
              title: getTranslation(context, "product_detail_text"),
              actions: commonActions(context),
              hasLeading: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  CachedNetworkImage(
                    errorWidget: (context, _, b) => const Center(
                      child: Icon(Icons.image_not_supported_outlined),
                    ),
                    imageUrl: product.imagesUrl!.isNotEmpty
                        ? '$BASE_API_URL_IMAGE/${product.imagesUrl!.first}'
                        : '',
                    width: 1.sw,
                    height: 240.r,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 6.h, 0, 10.h),
                    child: SizedBox(
                      height: 62.r,
                      child: product.imagesUrl!.isNotEmpty
                          ? ListView.builder(
                              itemCount: product.imagesUrl!.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.all(2.r),
                              itemBuilder: (context, index) {
                                return SmallImageSelector(
                                  imageUrl:
                                      '$BASE_API_URL_IMAGE/${product.imagesUrl![index]}',
                                  onPressed: () {
                                    setState(() {
                                      displayedImage =
                                          '$BASE_API_URL_IMAGE/${product.imagesUrl![index]}';
                                    });
                                  },
                                  isSelected:
                                      '$BASE_API_URL_IMAGE/${product.imagesUrl![index]}' ==
                                          displayedImage,
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: images.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.all(2.r),
                              itemBuilder: (context, index) {
                                return SmallImageSelector(
                                  imageUrl: images[index],
                                  onPressed: () {
                                    setState(() {
                                      displayedImage = images[index];
                                    });
                                  },
                                  isSelected: images[index] == displayedImage,
                                );
                              },
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const Divider(
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                      top: 4.h,
                      bottom: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // RoundedButton(
                        //   onPressed: () {
                        //     SnackBarService.showInfoSnackBar(
                        //         content: 'THIS FEATURE IS UNDER DEVELOPMENT');
                        //   },
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 10.w, vertical: 12.h),
                        //     child: Text(
                        //       getTranslation(context, "offer_text"),
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: TextStyle(fontSize: 16.sp),
                        //     ),
                        //   ),
                        // ),

                        // RoundedOutlinedButton(
                        //   onPressed: () {
                        //     // launchUrl(Uri(
                        //     //     scheme: 'tel',
                        //     //     path: product.seller.phone));
                        //   },
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(vertical: 12.h),
                        //     child: Row(
                        //       mainAxisAlignment:
                        //           MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         const Icon(
                        //           Icons.phone,
                        //           size: 20,
                        //         ),
                        //         SizedBox(
                        //           width: 6.w,
                        //         ),
                        //         Text(
                        //           getTranslation(context, "call_text"),
                        //           maxLines: 1,
                        //           overflow: TextOverflow.ellipsis,
                        //           style: TextStyle(fontSize: 16.sp),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        RoundedOutlinedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, ChatPage.routeName);
                            SnackBarService.showInfoSnackBar(
                                content: 'THIS FEATURE IS UNDER DEVELOPMENT');
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.chat,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  getTranslation(context, "chats_text"),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Product name and Price
                  DecoratedBox(
                    decoration: const BoxDecoration(color: kLightGreyColor),
                    child: RoundedCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: kDarkTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            product.subcategory.name!,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "ETB ${product.price}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: kDarkTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // /// Color Variant
                  // DecoratedBox(
                  //   decoration: const BoxDecoration(color: kLightGreyColor),
                  //   child: RoundedCard(
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           getTranslation(context, "color_text"),
                  //           style:
                  //               Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //                     color: kDarkTextColor,
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //         ),
                  //         SizedBox(
                  //           width: 16.h,
                  //         ),
                  //         ColorBox(
                  //           color: kPrimaryColor,
                  //           size: 20.w,
                  //         ),
                  //         ColorBox(
                  //           color: kBaseColor,
                  //           size: 20.w,
                  //         ),
                  //         ColorBox(
                  //           color: kSilverColor,
                  //           size: 20.w,
                  //         ),
                  //         ColorBox(
                  //           color: kTertiaryColor,
                  //           size: 20.w,
                  //         ),
                  //         ColorBox(
                  //           color: kSecondaryColor,
                  //           size: 20.w,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  /// Seller Info
                  DecoratedBox(
                      decoration: const BoxDecoration(color: kLightGreyColor),
                      child: RoundedCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslation(context, "Seller Information"),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: kDarkTextColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${getTranslation(context, "Name")} : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: kDarkTextColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.sp),
                                  ),
                                  Text(
                                    "${product.seller.firstName} ${product.seller.lastName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: kDarkTextColor,
                                            fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${getTranslation(context, "email_text")} : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: kDarkTextColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.sp),
                                  ),
                                  Text(
                                    product.seller.email!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: kDarkTextColor,
                                            fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "${getTranslation(context, "Phone")} : ",
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .headlineSmall
                              //           ?.copyWith(
                              //               color: kDarkTextColor,
                              //               fontWeight: FontWeight.w500,
                              //               fontSize: 18.sp),
                              //     ),
                              //     Text(
                              //       "${product.seller.phone} ",
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .headlineSmall
                              //           ?.copyWith(
                              //               color: kDarkTextColor,
                              //               fontSize: 14.sp),
                              //     ),
                              //   ],
                              // ),
                            ]),
                      )),

                  /// Product description
                  DecoratedBox(
                    decoration: const BoxDecoration(color: kLightGreyColor),
                    child: RoundedCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslation(context, "description_text"),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: kDarkTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            product.description!,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.6,
                                    ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  product.options.isNotEmpty
                      ? DecoratedBox(
                          decoration:
                              const BoxDecoration(color: kLightGreyColor),
                          child: RoundedCard(
                            child: SizedBox(
                              height: 300.h,
                              child: ListView.builder(
                                  itemCount: product.options.length,
                                  itemBuilder: (context, index) =>
                                      ExpansionTile(
                                        title: Text(
                                          product.options[index].optionId.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  color: kDarkTextColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18.sp),
                                        ),
                                        children: product.options[index].values
                                            .map((e) => Text(
                                                  e.value!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                          color: kDarkTextColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20.sp),
                                                ))
                                            .toList(),
                                      )),
                            ),
                          ))
                      : const SizedBox(),

                  /// Safety Tips
                  DecoratedBox(
                    decoration: const BoxDecoration(color: kLightGreyColor),
                    child: RoundedCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslation(context, "safety_text"),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: kDarkTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            getTranslation(context, "tip1_text"),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.6,
                                    ),
                          ),
                          Text(
                            getTranslation(context, "tip2_text"),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.6,
                                    ),
                          ),
                          Text(
                            getTranslation(context, "tip3_text"),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.6,
                                    ),
                          ),
                          Text(
                            getTranslation(context, "tip4_text"),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.6,
                                    ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Related Products
                  DecoratedBox(
                    decoration: const BoxDecoration(color: kLightGreyColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 24.h,
                          ),
                          child: Text(
                            getTranslation(context, "related_product_text"),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: kDarkTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: SizedBox(
                            height: 300.r,
                            child: BlocConsumer<ProductBloc, ProductState>(
                                listener: (context, state) {
                              if (state is ProductLoading) {
                                const CircularProgressIndicator();
                              }
                            }, builder: (context, state) {
                              if (state is ProductLoaded) {
                                Logger().d("related product inside detail: ",
                                    state.products.product![0]);
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.products.product!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, bottom: 6.h),
                                        child: FeaturedProductCard(
                                          product:
                                              state.products.product![index],
                                        ),
                                      );
                                    });
                              } else if (state is ProductError) {
                                return Center(child: Text(state.message));
                              }
                              return const SizedBox();
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (state is ProductDetailError) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Detail'),
          ),
          body: Center(
            child: Text(state.error),
          ),
        );
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    }));
  }
}
