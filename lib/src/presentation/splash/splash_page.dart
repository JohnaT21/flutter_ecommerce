import 'dart:async';

import 'package:ecommerce/src/presentation/bottom_navigator/pages/bottom_navigator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = "/splash_page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Timer(const Duration(milliseconds: 1500), () async {
      if (!mounted) return;
      //
      Navigator.of(context).pushReplacementNamed(
        BottomNavigatorPage.routeName,
      );
      // if (TOKEN != "") {

      // } else {
      //   Navigator.of(context).pushReplacementNamed(
      //     LoginPage.routeName,
      //   );
      // }
    });

    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        height: size.height,
        width: size.width,
        child: Center(
          child: Text(
            "Liyu",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: kBaseColor,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
          ),
        ),
      ),
    );
  }
}
