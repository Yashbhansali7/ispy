import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rooftop_ispy/screens/game.dart';
import 'package:rooftop_ispy/screens/home.dart';
import 'package:rooftop_ispy/screens/login.dart';
import 'package:rooftop_ispy/screens/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginScreen();
          },
        ),
        onGenerateRoute: (route) {
          switch (route.name) {
            case LoginScreen.routeName:
              return MaterialPageRoute(builder: (_) => const LoginScreen());
            case RegisterScreen.routeName:
              return MaterialPageRoute(builder: (_) => const RegisterScreen());
            case HomeScreen.routeName:
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            case GameScreen.routeName:
              String playerId = route.arguments as String;
              return MaterialPageRoute(
                  builder: (_) => GameScreen(playerId: playerId));
            default:
              return MaterialPageRoute(builder: (_) => const Scaffold());
          }
        });
  }
}
