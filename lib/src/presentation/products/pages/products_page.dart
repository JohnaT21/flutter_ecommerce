import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_filter/product_filter_bloc.dart';
import 'package:ecommerce/src/presentation/products/widgets/notification_icon.dart';
import 'package:ecommerce/src/presentation/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/localization_helper.dart';

class MyProductsPage extends StatelessWidget {
  static const routeName = "/my_products_page";

  const MyProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductFilterBloc>(context)
        .add(ProductFilterById(sellerId: USERID));
    return Scaffold(
        backgroundColor: kFadedBackgroundColor,
        appBar: AppBar(
            backgroundColor: kBaseColor,
            automaticallyImplyLeading: false,
            title: Text(
              getTranslation(context, "my_products_text"),
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 24.sp, color: kDarkTextColor, fontFamily: 'roboto'),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kDarkTextColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: NotificationIcon(),
              ),
              // IconButton(onPressed: (() {}), icon: Icon(Icons.notifications))
            ]),
        body: Container(
          padding: EdgeInsets.only(left: 10.w, right: 5.w, top: 28.h),
          child: BlocBuilder<ProductFilterBloc, ProductFilterState>(
              builder: (context, state) {
            if (state is ProductFilterLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductFilterLoaded) {
              if (state.products.isEmpty) {
                return Center(
                    child: Text(
                        "${getTranslation(context, "No Products")}\n        ${getTranslation(context, "add_text")}"));
              }
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: ((context, index) {
                  return ProductCard(product: state.products[index]);
                }),
              );
            } else if (state is ProductFilterError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          }),
        ));
  }
}
