import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';

Widget viewsWidget({int? view}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Icon(
        Icons.visibility,
        color: kPrimaryColor,
      ),
      Text('$view views'),
    ],
  );
}

Widget shareWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Icon(
        Icons.mobile_screen_share,
        color: kPrimaryColor,
      ),
      Text('0 Share'),
    ],
  );
}
