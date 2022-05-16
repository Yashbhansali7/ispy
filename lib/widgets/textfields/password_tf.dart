import 'package:flutter/material.dart';
import 'package:rooftop_ispy/globals.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _passwordHidder = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _passwordHidder,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        } else if (!RegExp(
                r'^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16}$')
            .hasMatch(value)) {
          return 'At least 1x upper case, 1x number and a minimum of 6 characters.';
        }
        return null;
      },
      cursorHeight: 20,
      style: const TextStyle(
        height: 1,
      ),
      controller: widget.passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        alignLabelWithHint: true,
        labelText: 'Password',
        isDense: true,
        errorMaxLines: 2,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
        enabledBorder: normalBorder,
        focusedBorder: normalBorder,
        border: normalBorder,
        errorBorder: normalBorder,
        focusedErrorBorder: errorBorder,
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _passwordHidder = !_passwordHidder;
            });
          },
          child: Icon(
            Icons.remove_red_eye,
            size: 22,
            color: _passwordHidder ? Colors.grey : Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
