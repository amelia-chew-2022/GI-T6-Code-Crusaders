import 'package:flutter/material.dart';
import './login.dart';

void main() {
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
