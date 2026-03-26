import 'package:flutter/material.dart';
import 'package:welcome_sheffield/main_scaffold.dart';
import 'tutorial_screen.dart';
import 'language_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/welcome_sheffield.jpg",
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  Container(
                        height: 220,
                        decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                            ],
                        ),
                        ),
                    ),
                    ],
                ),
                ),


              const SizedBox(height: 20),

              const Text(
                "Welcome to Sheffield",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "This app helps newcomers find essential services quickly — health, housing, safety, and local support.",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 14),

              _BulletRow(icon: Icons.search, text: "Search topics and services"),
              _BulletRow(icon: Icons.map_outlined, text: "Find help near you"),
              _BulletRow(icon: Icons.warning_amber_rounded, text: "Quick emergency access"),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const TutorialScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF13384A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const LanguageScreen()),);
                  },
                  child: const Text("Change language"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BulletRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
