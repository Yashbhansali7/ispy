import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rooftop_ispy/screens/game.dart';
import 'package:rooftop_ispy/screens/login.dart';
import 'package:rooftop_ispy/widgets/helpers/default_text.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('I-SPY'), actions: [
        TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const DefaultText(
              text: 'Log out',
              color: Colors.white,
              fontSize: 16,
            ))
      ]),
      body: StreamBuilder(
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final userDocs = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: userDocs.length,
              itemBuilder: (context, index) {
                final singleUser = userDocs[index].data() as Map;
                if (_user!.uid == userDocs[index].id) {
                  return const SizedBox();
                }
                return Container(
                    color: Colors.deepPurple[100],
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(singleUser['avatar']),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  text: singleUser['name'],
                                  weight: FontWeight.w300,
                                  fontSize: 26,
                                ),
                                const SizedBox(height: 5),
                                DefaultText(
                                  text: singleUser['email'],
                                  weight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ],
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  GameScreen.routeName,
                                  arguments: userDocs[index].id);
                            },
                            child: const Text('PLAY'))
                      ],
                    ));
              },
            );
          },
          stream: FirebaseFirestore.instance.collection('users').snapshots()),
    );
  }
}
