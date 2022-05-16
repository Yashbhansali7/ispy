import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;

  const DefaultText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.weight,
      this.color,
      this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align ?? TextAlign.left,
        style: TextStyle(
            color: color ?? Colors.black,
            fontWeight: weight,
            fontSize: fontSize));
  }
}
