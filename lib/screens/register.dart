import 'package:flutter/material.dart';
import 'package:rooftop_ispy/widgets/auth/auth_footer.dart';
import 'package:rooftop_ispy/widgets/auth/register_form.dart';
import 'package:rooftop_ispy/widgets/helpers/default_text.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  height: MediaQuery.of(context).size.height * .28,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        DefaultText(
                          text: 'I-SPY',
                          fontSize: 50,
                          weight: FontWeight.w900,
                        ),
                        SizedBox(height: 16),
                        DefaultText(
                          text: 'Sign Up',
                          fontSize: 22,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    child: const RegisterForm(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                  child: const AuthFooter(
                      subText: 'Already have an Account?', buttonText: 'Login'),
                )
              ],
            ),
          ),
        ));
  }
}
