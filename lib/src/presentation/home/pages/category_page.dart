import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/data/models/category_model.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_state.dart';
import 'package:ecommerce/src/presentation/home/blocs/sub_category_bloc/sub_category_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/sub_category_bloc/sub_category_state.dart';
import 'package:ecommerce/src/presentation/home/widgets/single_category_item.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_by_sub_category_bloc/product_by_sub_category_bloc.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_by_sub_category_bloc/product_by_sub_category_event.dart';
import 'package:ecommerce/src/presentation/products/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/localization_helper.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = "/category_page";

  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CategroyModel;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: kBaseColor,
            automaticallyImplyLeading: false,
            elevation: 1,
            title: Text(
              args.name,
              style:const TextStyle(color: kDarkTextColor),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kDarkTextColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: BlocBuilder<SubCategoryBloc, SubCategoryState>(
            builder: (context, state) {
          if (state is SubCategoriesInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SubCategoriesLoaded) {
            final subCategories = state.subCategories;
            if (subCategories.isEmpty) {
              return Center(
                child: Text(getTranslation(context, "No subcategories")),
              );
            }
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: subCategories.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<ProductsBySubcategoryBloc>(context)
                              .add(GetProductsBySubcategory(
                                  id: subCategories[index].id));
                          Navigator.pushNamed(context, ProductPage.routeName);
                        },
                        child: SingleCategoryItem(
                          name: subCategories[index].name,
                          imageURL: subCategories[index].imageURL.isNotEmpty
                              ? "$BASE_API_URL_IMAGE/${subCategories[index].imageURL[0]}"
                              : '',
                          description: subCategories[index].description,
                        ),
                      );
                    }),
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: const Divider(
                          thickness: 1,
                        ),
                      );
                    }));
          } else if (state is CategoriesError) {
            return Center(
              child: Text(getTranslation(context,"Errors")),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}
