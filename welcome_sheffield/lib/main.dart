import 'package:flutter/material.dart';
import 'main_scaffold.dart';
import 'screens/home_content.dart';

void main() {
  runApp(const WelcomeSheffieldApp());
}

class WelcomeSheffieldApp extends StatelessWidget {
  const WelcomeSheffieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Sheffield',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MainScaffold(
        child: HomeContent(),
        currentIndex: 0,
      ),
    );
  }
}