import 'package:flutter/material.dart';

class SnackBarService {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  static void showNormalSnackBar({required String content}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }

  static void showInfoSnackBar({required String content}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }

  static void showSuccessSnackBar(
      {required String content, int? duration = 5000}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      duration: Duration(milliseconds: duration!),
      content: Text(content),
      backgroundColor: Colors.green,
    ));
  }

  static void showErrorSnackBar({required String content}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: Colors.redAccent,
    ));
  }
}
