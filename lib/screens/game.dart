import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rooftop_ispy/services/game_service.dart';
import 'package:rooftop_ispy/widgets/helpers/bottom_sheet.dart';
import 'package:rooftop_ispy/widgets/helpers/default_text.dart';
import 'package:rooftop_ispy/widgets/helpers/snackbar.dart';
import 'package:rooftop_ispy/widgets/ui/image_selector.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game';
  final String playerId;
  const GameScreen({Key? key, required this.playerId}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  TextEditingController letterController = TextEditingController();
  bool isPlayedBefore = false;
  QuerySnapshot? gameCheck;
  File? image;

  createGame() async {
    if (image == null) {
      CustomSnack.showSnack(context, 'Please provide a hint.', 20);
      return;
    }
    if (letterController.text.isEmpty) {
      CustomSnack.showSnack(context, 'Please select an image', 20);
      return;
    }
    GameServices().createGame(
        widget.playerId, letterController.text.toUpperCase(), image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Game')),
        body: StreamBuilder(
            stream: _firestore.collection('games').where('players',
                arrayContainsAny: [widget.playerId, _user!.uid]).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map? game;
              if (snapshot.data!.docs.isNotEmpty) {
                game = snapshot.data!.docs[0].data() as Map;
              }
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    GestureDetector(
                        onTap: () {
                          game == null
                              ? null
                              : CustomBottomSheet().showSheet(
                                  context: context,
                                  widget: ImageSelector(
                                      outerFile: (i) {
                                        image = i;
                                        setState(() {});
                                      },
                                      title: 'Game Image',
                                      showClose: false));
                        },
                        child: Container(
                            height: 400,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: game == null
                                ? image != null
                                    ? Image.file(image!, fit: BoxFit.cover)
                                    : const Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 70,
                                          color: Colors.deepPurple,
                                        ),
                                      )
                                : Image.network(game['currentImage'],
                                    fit: BoxFit.cover))),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: DefaultText(
                          align: TextAlign.center,
                          fontSize: 20,
                          text:
                              'I spy with my little eye a thing starting with the letter'),
                    ),
                    Center(
                      child: SizedBox(
                        width: 30,
                        child: game == null
                            ? TextField(
                                maxLength: 1,
                                controller: letterController,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: DefaultText(
                                    text: game['letter'],
                                    fontSize: 30,
                                    weight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: SizedBox(
                            width: 180,
                            child: FloatingActionButton.extended(
                                onPressed: () {
                                  if (game == null) {
                                    createGame();
                                  } else {}
                                },
                                label: Row(
                                  children: const [
                                    DefaultText(
                                      text: 'Send',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 15),
                                    Icon(Icons.send)
                                  ],
                                )))),
                  ],
                ),
              );
            }));
  }
}
