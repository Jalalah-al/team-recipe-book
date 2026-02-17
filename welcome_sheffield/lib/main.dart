import 'package:flutter/material.dart';
import 'main_scaffold.dart';
import 'screens/content.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const WelcomeSheffieldApp());
}

class WelcomeSheffieldApp extends StatelessWidget {
  const WelcomeSheffieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF13384A),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF13384A),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
        ),

        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      ),

      home: const ContentPage(title: "Test Page"),

    );
  }
}