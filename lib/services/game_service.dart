import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rooftop_ispy/services/image_service.dart';

class GameServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  createGame(String playerId, String letter, File image) async {
    String url = await ImageService().uploadImage(
        image, 'gameImages/${_user!.email}/${image.path.split('/').last}');
    await _firestore.collection('games').add({
      'playerId': playerId,
      'senderId': _user!.uid,
      'players': [playerId, _user!.uid],
      'status': 'active',
      'nextMove': 'player',
      'points': 0,
      'letter': letter,
      'initialImage': url,
      'currentImage': url
    });
  }

  updateNextMove(String id, String mover) async {
    _firestore.collection('games').doc(id).update({'nextMove': mover});
  }

  updatePoints(String id, int points) async {
    _firestore.collection('games').doc(id).update({'points': points});
  }

  updateStatus(String id, String status) async {
    _firestore.collection('games').doc(id).update({'status': status});
  }
}
