import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rooftop_ispy/globals.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController emailController;
  const EmailTextField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  _EmailTextFieldState createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email Address cannot be empty';
        } else if (!EmailValidator.validate(value)) {
          return 'Email Address is invalid.';
        }
        return null;
      },
      cursorHeight: 20,
      style: const TextStyle(
        height: 1,
      ),
      controller: widget.emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        alignLabelWithHint: true,
        labelText: 'Email Address',
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
        enabledBorder: normalBorder,
        focusedBorder: normalBorder,
        border: normalBorder,
        errorBorder: normalBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
