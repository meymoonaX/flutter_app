import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const LearnifyApp());
}

class LearnifyApp extends StatelessWidget {
  const LearnifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnify (EduPath)',
      debugShowCheckedModeBanner: false,
      theme: buildLearnifyTheme(),
      home: const LoginScreen(),
    );
  }
}
