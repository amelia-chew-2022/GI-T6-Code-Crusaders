import 'package:flutter/material.dart';
import './login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the configuration options
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyC4S8tzOwRB9O8QTpg2HdSGPElLsPP4Erc",
        authDomain: "pantry-pal-8faa1.firebaseapp.com",
        projectId: "pantry-pal-8faa1",
        storageBucket: "pantry-pal-8faa1.appspot.com",
        messagingSenderId: "450783420881",
        appId: "1:450783420881:web:860b44e178caae9b8540f0",
        measurementId: "G-EX4934RMG5"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  //dummy info
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF0F5F2),
          useMaterial3: false),
      home: Login(), //need change back to Login()
    );
  }
}
