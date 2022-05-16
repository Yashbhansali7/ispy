import 'package:flutter/material.dart';

class CustomSnack {
  static showSnack(BuildContext context, String title, double bottomMargin,
      [double? iOSReduction]) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, bottomMargin),
        backgroundColor: Colors.black38,
        content: Text(title)));
  }
}
