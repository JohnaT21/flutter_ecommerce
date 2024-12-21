import 'package:flutter/material.dart';

import 'constants.dart';

InputDecoration inputDecoration(String hint, Widget? suffix,
    {bool enabled = true}) {
  return InputDecoration(
    suffixIcon: suffix,
    filled: true,
    enabled: enabled,
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 1.0,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 1.0,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: kLightGreyColor)),
    fillColor: kBaseColor,
    labelStyle: const TextStyle(color: kDarkGreyColor),
    focusColor: kPrimaryColor,
    labelText: hint,
  );
}

InputDecoration searchInputDecoration(String hint) {
  return InputDecoration(
    // filled: true,
    contentPadding: EdgeInsets.zero,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBaseColor)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBaseColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBaseColor)),
    fillColor: Colors.grey[100],
    hintStyle: const TextStyle(fontSize: 14),
    hintText: hint,
  );
}
