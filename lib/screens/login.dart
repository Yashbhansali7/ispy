import 'package:flutter/material.dart';
import 'package:rooftop_ispy/widgets/auth/auth_footer.dart';
import 'package:rooftop_ispy/widgets/auth/login_form.dart';
import 'package:rooftop_ispy/widgets/helpers/default_text.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .38,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        DefaultText(
                          text: 'I-SPY',
                          fontSize: 50,
                          weight: FontWeight.w900,
                        ),
                        SizedBox(height: 26),
                        DefaultText(
                          text: 'Log In',
                          fontSize: 22,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 34.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .46,
                    child: const LoginForm(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                  child: const AuthFooter(
                      subText: 'Don\'t have an account ?',
                      buttonText: 'Sign Up'),
                )
              ],
            ),
          )),
    );
  }
}
