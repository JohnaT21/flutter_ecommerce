import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_event.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_state.dart';
import 'package:ecommerce/src/presentation/home/blocs/shop_bloc/shop_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/sub_category_bloc/sub_category_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/sub_category_bloc/sub_category_event.dart';
import 'package:ecommerce/src/presentation/home/pages/category_page.dart';
import 'package:ecommerce/src/presentation/home/widgets/home_appbar.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_bloc.dart';
import 'package:ecommerce/src/presentation/shared_widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/localization_helper.dart';
import '../../../core/helpers/product_helpers.dart';
import '../../../core/helpers/push_notification_service.dart';
import '../../../data/models/products_response_model.dart';
import '../../chat/bloc/chat_bloc.dart';
import '../../favorite/bloc/favorite_bloc.dart';
import '../../shared_widgets/carousel_widget.dart';
import '../../shared_widgets/featured_product_card.dart';
import '../../shared_widgets/slider_item.dart';
import '../blocs/shop_bloc/shop_event.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> getData() async {
    BlocProvider.of<FavoriteBloc>(context).add(GetAllFavoriteEvent());
    BlocProvider.of<ChatBloc>(context).add(GetChatListEvent());
    BlocProvider.of<ShopBloc>(context).add(const GetShop());
    BlocProvider.of<CategoryBloc>(context).add(const GetCategories());
    BlocProvider.of<ProductBloc>(context).add(const LoadProducts());
  }

  @override
  void initState() {
    super.initState();
    PushNotificationService().initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return getData();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const HomeAppBar(),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  /// Slider
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: SizedBox(
                      height: 200.h,
                      width: 1.sw,
                      child: const CarouselWithIndicator(
                        items: [
                          SliderItem(image: "assets/images/clothes.png"),
                          SliderItem(image: "assets/images/furniture.png"),
                          SliderItem(image: "assets/images/pc.png"),
                          SliderItem(image: "assets/images/cosmo.png"),
                          SliderItem(image: "assets/images/mens.png"),
                        ],
                      ),
                    ),
                  ),

                  /// Categories
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 0.h, 24.w, 0.h),
                    child: BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                      if (state is CategoriesInitial) {
                        context.read<CategoryBloc>().add(const GetCategories());
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CategoriesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CategoriesLoaded) {
                        final categories = state.categories;
                        if (categories.isEmpty) {
                          return Center(
                            child:
                                Text(getTranslation(context, "NO Categories")),
                          );
                        }
                        return GridView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 16.h,
                                    crossAxisSpacing: 32.w,
                                    childAspectRatio: 0.82),
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<SubCategoryBloc>(context).add(
                                      GetSubCategories(
                                          id: categories[index].id));

                                  Navigator.pushNamed(
                                      context, CategoryPage.routeName,
                                      arguments: categories[index]);
                                },
                                child: CategoryItem(
                                    image:
                                        "$BASE_API_URL_IMAGE${categories[index].imageURL}",
                                    name: categories[index].name),
                              );
                            }));
                      } else {
                        return Center(
                          child: Text(getTranslation(context, "Errors")),
                        );
                      }
                    }),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),

                  /// Featured Products
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                    child: Text(
                      getTranslation(context, "featured_product_text"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: kDarkTextColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      color: kLightGreyColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: SizedBox(
                        height: 300.r,
                        child: BlocConsumer<ProductBloc, ProductState>(
                            listener: (context, state) {
                          if (state is ProductLoading) {
                            const CircularProgressIndicator();
                          }
                        }, builder: (context, state) {
                          if (state is ProductLoaded) {
                            List<Product> products = filterFeaturedProducts(
                                allProducts: state.products.product!);
                            if (products.isEmpty) {
                              return Center(
                                child: Text(getTranslation(
                                    context, "NO FEATURED PRODUCT")),
                              );
                            }
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.w, bottom: 6.h),
                                    child: FeaturedProductCard(
                                      product: products[index],
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
                  ),
                  SizedBox(
                    height: 16.h,
                  ),

                  /// Featured shops
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 24.h),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 20.w),
                  //         child: Text(
                  //           getTranslation(context, "featured_shop_text"),
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //           style:
                  //               Theme.of(context).textTheme.headline6?.copyWith(
                  //                     color: kDarkTextColor,
                  //                     fontSize: 22.sp,
                  //                     fontWeight: FontWeight.w700,
                  //                   ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 16.h,
                  //       ),
                  //       SizedBox(
                  //         height: 300.r,
                  //         child: BlocConsumer<ShopBloc, ShopState>(
                  //             listener: (context, shopState) {
                  //           if (shopState is ProductLoading) {
                  //             const CircularProgressIndicator();
                  //           }
                  //         }, builder: (context, shopState) {
                  //           if (shopState is ShopError) {
                  //             return Center(
                  //               child: Text(shopState.error),
                  //             );
                  //           }
                  //           if (shopState is ShopLoaded) {
                  //             if (shopState.shops.data!.isEmpty) {
                  //               return Center(
                  //                 child: Text(getTranslation(
                  //                     context, "NO FEATURED SHOP")),
                  //               );
                  //             } else {
                  //               return ListView.builder(
                  //                   scrollDirection: Axis.horizontal,
                  //                   itemCount: shopState.shops.data!.length,
                  //                   itemBuilder: (context, index) {
                  //                     return Padding(
                  //                       padding: EdgeInsets.only(
                  //                           left: 20.w, bottom: 6.h),
                  //                       child: FeaturedShopCard(
                  //                         shop: shopState.shops.data![index],
                  //                       ),
                  //                     );
                  //                   });
                  //             }
                  //           }
                  //           return const SizedBox();
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // /// Shop Category
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  //   child: Text(
                  //     "SHOP BY CATEGORY",
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: Theme.of(context).textTheme.headline6?.copyWith(
                  //           color: kDarkTextColor,
                  //           fontSize: 22.sp,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //   ),
                  // ),
                  // DecoratedBox(
                  //   decoration: const BoxDecoration(color: kLightGreyColor),
                  //   child: Padding(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  //     child: GridView.count(
                  //       crossAxisCount: 2,
                  //       primary: false,
                  //       shrinkWrap: true,
                  //       mainAxisSpacing: 16.h,
                  //       crossAxisSpacing: 16.w,
                  //       childAspectRatio: 1.1,
                  //       children: const [
                  //         ShopCategoryCard(
                  //             image: "assets/images/cloth.jpg", name: "Clothing"),
                  //         ShopCategoryCard(
                  //             image: "assets/images/electronics.jpg",
                  //             name: "Electronics"),
                  //         ShopCategoryCard(
                  //             image: "assets/images/shoe.jpg", name: "Shoes"),
                  //         ShopCategoryCard(
                  //             image: "assets/images/house.jpg", name: "House"),
                  //         ShopCategoryCard(
                  //             image: "assets/images/cosmo.png", name: "Makeup"),
                  //         ShopCategoryCard(
                  //             image: "assets/images/furniture.jpg",
                  //             name: "Furniture"),
                  //         ShopCategoryCard(
                  //             image: "assets/images/sports.jpg", name: "Sports"),
                  //         ShopCategoryCard(
                  //             image: "assets/images/vehicle.jpg",
                  //             name: "Vehicles"),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 16.h,
                  ),

                  /// New Arrivals
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
                    child: Text(
                      getTranslation(context, "new_arrival_text"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: kDarkTextColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      color: kLightGreyColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: SizedBox(
                        height: 300.r,
                        child: BlocConsumer<ProductBloc, ProductState>(
                            listener: (context, state) {
                          if (state is ProductLoading) {
                            const CircularProgressIndicator();
                          }
                        }, builder: (context, state) {
                          if (state is ProductLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is ProductLoaded) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.products.product!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.w, bottom: 6.h),
                                    child: FeaturedProductCard(
                                      product: state.products.product![index],
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
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
