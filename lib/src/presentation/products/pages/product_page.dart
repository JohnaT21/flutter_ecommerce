import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_by_sub_category_bloc/product_by_sub_category_bloc.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_by_sub_category_bloc/product_by_sub_category_state.dart';
import 'package:ecommerce/src/presentation/products/widgets/featured_product_card_by_sub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/localization_helper.dart';

class ProductPage extends StatefulWidget {
  static const routeName = "/product__page";
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kBaseColor,
            automaticallyImplyLeading: false,
            title: Text(
              getTranslation(context, "product_text"),
              style: const TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kDarkTextColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )),
        body:
            BlocBuilder<ProductsBySubcategoryBloc, ProductsBySubcategoryState>(
                builder: (context, state) {
          if (state is ProductsBySubcategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsBySubcategoryLoaded) {
            final products = state.products.data.product;
            if (products!.isEmpty) {
              return Center(
                child: Text(getTranslation(context, "No Products")),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: kBaseColor),
                    //     onPressed: () {},
                    //     child: Text(
                    //       getTranslation(context, "filter_text"),
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .titleLarge
                    //           ?.copyWith(
                    //             color: kBlueColor,
                    //             fontSize: 18.sp,
                    //             fontWeight: FontWeight.w600,
                    //             letterSpacing: 0.6,
                    //           ),
                    //     )),

                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16.h,
                            crossAxisSpacing: 32.w,
                            childAspectRatio: 0.82),
                        itemBuilder: ((context, index) {
                          return FeaturedProductCardBySub(
                              product: products[index]);
                        }),
                      ),
                    ),
                  ]),
            );
          } else if (state is ProductsBySubcategoryError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Container();
          }
        }));
  }
}
