import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rooftop_ispy/services/auth_services.dart';
import 'package:rooftop_ispy/widgets/helpers/default_text.dart';
import 'package:rooftop_ispy/widgets/textfields/email_tf.dart';
import 'package:rooftop_ispy/widgets/textfields/password_tf.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final emailKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool forgetActive = false;
  checkEmail(String text) {
    if (EmailValidator.validate(text)) {
      forgetActive = true;
    } else {
      forgetActive = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Form(
            key: emailKey,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: EmailTextField(emailController: emailController)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child:
                      PasswordTextField(passwordController: passwordController),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
                height: 52,
                margin: const EdgeInsets.only(top: 32),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepPurple[700],
                    borderRadius: BorderRadius.circular(8)),
                child: isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const DefaultText(
                        text: 'Log In',
                        weight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      )),
            onTap: () async {
              if (emailKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                await AuthServices().firebaseLogin(emailController.text.trim(),
                    passwordController.text.trim(), context);
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
