import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
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
      title: 'Welcome to Sheffield',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF13384A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF13384A),
          foregroundColor: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SplashScreen(),  
    );
  }
}
