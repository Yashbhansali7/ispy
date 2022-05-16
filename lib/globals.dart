import 'package:flutter/material.dart';

OutlineInputBorder normalBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    //gapPadding: 6,
    borderSide: BorderSide(
      width: .5,
      color: Colors.black.withOpacity(.2),
      style: BorderStyle.solid,
    ));
OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(
      width: .5,
      color: Colors.red,
      style: BorderStyle.solid,
    ));
