import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ecoclean/views/menu.dart';
import 'controller/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true),
        title: 'firebase auth example',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Menu();
            } else {
              return Login();
            }
          },
        ));
  }
}

