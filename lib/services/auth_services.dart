import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rooftop_ispy/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rooftop_ispy/services/image_service.dart';
import 'package:rooftop_ispy/widgets/helpers/snackbar.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future firebaseLogin(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      CustomSnack.showSnack(
          context,
          e.code == 'user-not-found' || e.code == 'wrong-password'
              ? 'Email or Password is incorrect'
              : "Can't Login right now. Please try again later.",
          40);
    }
  }

  Future firebaseRegister(
      {required String email,
      required String password,
      required String name,
      required BuildContext context,
      File? file}) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await saveFirebaseData(
        email: email,
        name: name,
        file: file,
        userCredentials: cred,
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CustomSnack.showSnack(context, "Email is already in use.", 60);
      }
    }
  }

  saveFirebaseData(
      {required UserCredential userCredentials,
      required String email,
      required String name,
      File? file}) async {
    String url = '';
    if (file != null) {
      url = await ImageService().uploadImage(file,
          'avatarImages/${userCredentials.user!.email}/${file.path.split('/').last}');
    }
    // adding user in our database
    await _firestore
        .collection("users")
        .doc(userCredentials.user!.uid)
        .set({'name': name, 'email': email, 'avatar': url});
  }
}
