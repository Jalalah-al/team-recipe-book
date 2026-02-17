import 'package:flutter/material.dart';
import 'main_scaffold.dart';

void main() {
  runApp(const MyTestApp());
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScaffold(
        child: Container(
          color: Colors.white,  
        ),
      ),
    );
  }
}