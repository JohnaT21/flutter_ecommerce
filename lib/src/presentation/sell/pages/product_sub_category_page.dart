import 'package:ecommerce/src/domain/entities/product_category.dart';
import 'package:ecommerce/src/presentation/sell/pages/sell_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../core/helpers/pop_result.dart';
import '../bloc/sell_bloc.dart';

class ProductSubCategoryPage extends StatefulWidget {
  static const String routeName = "/product_sub_category_page";

  const ProductSubCategoryPage({super.key});

  @override
  State<ProductSubCategoryPage> createState() => _ProductSubCategoryPageState();
}

class _ProductSubCategoryPageState extends State<ProductSubCategoryPage> {
  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as List<Subcategory>;
    final sellBloc = BlocProvider.of<SellBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBaseColor,
        title: Text(getTranslation(context, "Product Sub Category"),
            style: const TextStyle(color: kDarkTextColor)),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: kDarkTextColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
            children: args
                .map(
                  (e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(
                            PopWithResults(
                                fromPage: "/product_sub_category_page",
                                toPage: SellPage.routeName,
                                results: e,
                                option: []),
                          );
                          Navigator.of(context).pop(
                            PopWithResults(
                                fromPage: "/product_sub_category_page",
                                toPage: SellPage.routeName,
                                results: e,
                                option: []),
                          );
                        },
                        child: AnimatedContainer(
                          height: 55,
                          width: screenWidth,
                          curve: Curves.easeInOut,
                          duration: Duration(
                              milliseconds: 300 + (args.indexOf(e) * 200)),
                          transform: Matrix4.translationValues(
                              startAnimation ? 0 : screenWidth, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(
                                color: kGreyBorderColor,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              title: Text(e.name),
                            ),
                          ),
                        ),
                      )),
                )
                .toList()),
      ),
    );
  }
}
