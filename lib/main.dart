import 'package:flutter/material.dart';
import 'package:flutter_password_validation/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Password Validation',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
