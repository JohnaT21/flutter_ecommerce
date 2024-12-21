import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductDetailTestPage extends StatefulWidget {
    static const String routeName = "/product_test_page";

  const ProductDetailTestPage({super.key});

  @override
  State<ProductDetailTestPage> createState() => _ProductDetailTestPageState();
}

class _ProductDetailTestPageState extends State<ProductDetailTestPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: Text("on Test Detail"),
      ),
    );
  }
}