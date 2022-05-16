import 'package:flutter/material.dart';
import 'package:rooftop_ispy/screens/login.dart';
import 'package:rooftop_ispy/screens/register.dart';

class AuthFooter extends StatelessWidget {
  final String subText;
  final String buttonText;
  const AuthFooter({Key? key, required this.subText, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          subText,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        TextButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              buttonText == 'Login'
                  ? Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName)
                  : Navigator.of(context)
                      .pushReplacementNamed(RegisterScreen.routeName);
            },
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.deepPurple),
            ))
      ],
    );
  }
}
