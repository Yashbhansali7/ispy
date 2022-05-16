import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rooftop_ispy/globals.dart';
import 'package:rooftop_ispy/services/auth_services.dart';
import 'package:rooftop_ispy/widgets/helpers/bottom_sheet.dart';
import 'package:rooftop_ispy/widgets/helpers/default_text.dart';
import 'package:rooftop_ispy/widgets/helpers/snackbar.dart';
import 'package:rooftop_ispy/widgets/textfields/email_tf.dart';
import 'package:rooftop_ispy/widgets/textfields/password_tf.dart';
import 'package:rooftop_ispy/widgets/ui/image_selector.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  File? image;
  bool isLoading = false;
  final registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerKey,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    CustomBottomSheet().showSheet(
                        context: context,
                        widget: ImageSelector(
                            showClose: true,
                            title: 'Profile Image',
                            outerFile: (i) => setState(() {
                                  image = i;
                                })));
                  },
                  child: CircleAvatar(
                      radius: 49,
                      backgroundImage: image == null ? null : FileImage(image!),
                      child: image == null ? const Icon(Icons.add) : null),
                ),
                image != null
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepPurple[700],
                                borderRadius: BorderRadius.circular(20)),
                            height: 28,
                            width: 28,
                            child: const Icon(Icons.edit,
                                size: 14, color: Colors.white)),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 30),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
                cursorHeight: 20,
                style: const TextStyle(
                  height: 1,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: nameController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  alignLabelWithHint: true,
                  labelText: 'Name',
                  isDense: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Colors.black),
                  enabledBorder: normalBorder,
                  focusedBorder: normalBorder,
                  border: normalBorder,
                  errorBorder: normalBorder,
                  focusedErrorBorder: errorBorder,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: EmailTextField(emailController: emailController)),
          Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: PasswordTextField(passwordController: passwordController)),
          GestureDetector(
            child: Container(
                height: 52,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20, top: 20),
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
                        text: 'Continue',
                        weight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      )),
            onTap: () async {
              if (isLoading) {
                return;
              }
              if (image == null) {
                CustomSnack.showSnack(
                    context, 'Please select a profile image.', 60);
                return;
              }
              if (registerKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });

                await AuthServices().firebaseRegister(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  name: nameController.text.trim(),
                  context: context,
                  file: image!,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
