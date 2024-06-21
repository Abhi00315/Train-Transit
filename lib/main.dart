import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/login/login_pg.dart';
import 'firebase_options.dart'; // Ensure you have firebase_options.dart generated from FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
