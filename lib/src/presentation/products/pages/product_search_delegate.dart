import 'package:ecommerce/src/presentation/shared_widgets/featured_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/constants.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../data/models/products_response_model.dart';
import '../../../di/injector.dart';
import '../bloc/product_search/product_search_bloc.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
  var searchBloc = sl<ProductSearchBloc>();
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            })
      ];

  @override
  Widget? buildLeading(BuildContext context) => Container(
        child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              close(context, null);
            }),
      );

  @override
  Widget buildResults(BuildContext context) => Container();
  @override
  Widget buildSuggestions(BuildContext context) {
    sl<ProductSearchBloc>().add(SearchProducts(query: query));
    return BlocBuilder(
      bloc: searchBloc,
      builder: (BuildContext context, ProductSearchState state) {
        if (state is ProductSearchLoading) {
          return const Center(
            child: SizedBox(
                height: 25, width: 25, child: CircularProgressIndicator()),
          );
        } else if (state is ProductSearchError) {
          return Center(
              child: Text(
                  "${getTranslation(context, "Errors")} : ${state.message}"));
        } else if (state is ProductSearchLoaded) {
          return SizedBox(
            width: 1.sw,
            height: (1.sh - 70.h),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: kFadedBackgroundColor,
              ),
              child: GridView.builder(
                itemCount:
                    state.products.length, //widget.artist.albums!.length,
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
                  return FeaturedProductCard(
                    product: state.products[index],
                  );
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
