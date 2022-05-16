import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadImage(File file, String path) async {
    try {
      var task = await _storage.ref().child(path).putFile(file);
      return await task.ref.getDownloadURL();
    } on FirebaseException catch (error) {
      // ignore: avoid_print
      print(error);
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
    return '';
  }
}
