import 'package:ecommerce/src/domain/entities/product_category.dart';
import 'package:ecommerce/src/presentation/sell/pages/product_sub_category_page.dart';
import 'package:flutter/material.dart';

import '../../../config/constants.dart';

class ProductCategoryPage extends StatefulWidget {
  static const String routeName = "/product_category_page";

  const ProductCategoryPage({super.key});

  @override
  State<ProductCategoryPage> createState() => ProductCategoryPageState();
}

String dropDownValue = "";
List<String> cates = [];

class ProductCategoryPageState extends State<ProductCategoryPage> {
  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

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
    final args = ModalRoute.of(context)!.settings.arguments as ProductCategory;
    return Scaffold(
        // key: _globalKey,
        appBar: AppBar(
          backgroundColor: kBaseColor,
          title: const Text("Product Category",
              style: TextStyle(color: kDarkTextColor)),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios, color: kDarkTextColor)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
              children: args.data
                  .map(
                    (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            e.subcategory.isNotEmpty
                                ? Navigator.pushNamed(
                                    context, ProductSubCategoryPage.routeName,
                                    arguments: e.subcategory)
                                : null;
                          },
                          child: AnimatedContainer(
                            height: 55,
                            width: screenWidth,
                            curve: Curves.easeInOut,
                            duration: Duration(
                                milliseconds:
                                    300 + (args.data.indexOf(e) * 200)),
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
                                trailing: e.subcategory.isNotEmpty
                                    ? const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: kTertiaryColor,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        )),
                  )
                  .toList()),
        ));
  }
}
