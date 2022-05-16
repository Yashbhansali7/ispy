import 'package:flutter/material.dart';

class CustomBottomSheet {
  Future showSheet({required context, required Widget widget}) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.deepPurple[100],
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return widget;
        });
  }
}
