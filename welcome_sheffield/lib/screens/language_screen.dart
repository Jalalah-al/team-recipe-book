import 'package:flutter/material.dart';
import 'package:welcome_sheffield/app_state.dart';
import 'welcome_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = "en";
  String searchQuery = "";

  final List<Map<String, String>> languages = const [
    {"code": "en", "label": "English"},
    {"code": "ar", "label": "Arabic (العربية)"},
    {"code": "de", "label": "German (Deutsch)"},
    {"code": "pl", "label": "Polish (Polski)"},
    {"code": "es", "label": "Spanish (Español)"},
    {"code": "fr", "label": "French (Français)"},
    {"code": "ur", "label": "Urdu (اردو)"},
    {"code": "zh", "label": "Mandarin Chinese (中文)"},
    {"code": "ro", "label": "Romanian (Română)"},
    {"code": "sk", "label": "Slovak (Slovenčina)"},
  ];

  List<Map<String, String>> get filteredLanguages {
    if (searchQuery.trim().isEmpty) return languages;

    return languages.where((lang) {
      final label = lang["label"]!.toLowerCase();
      final code = lang["code"]!.toLowerCase();
      final query = searchQuery.toLowerCase();
      return label.contains(query) || code.contains(query);
    }).toList();
  }

  String getSelectedLabel() {
    return languages.firstWhere((lang) => lang["code"] == selectedLanguage)["label"]!;
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF13384A),
        foregroundColor: Colors.white,
        title: Text(appState.tr("choose_language_title")),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              appState.tr("choose_language_desc"),
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 25),
            Text(
              appState.tr("you_selected"),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSelectedCard(),
            const SizedBox(height: 25),
            Text(
              appState.tr("all_languages"),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSearchBar(appState),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLanguages.length,
                itemBuilder: (context, index) {
                  final language = filteredLanguages[index];
                  final isSelected = language["code"] == selectedLanguage;

                  return ListTile(
                    title: Text(language["label"]!),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: Colors.teal)
                        : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
                    onTap: () {
                      setState(() {
                        selectedLanguage = language["code"]!;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  appState.changeLanguage(selectedLanguage);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  );
                },
                child: Text(
                  appState.tr("continue"),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.teal),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              getSelectedLabel(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.check_circle, color: Colors.teal),
        ],
      ),
    );
  }

  Widget _buildSearchBar(dynamic appState) {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: appState.tr("search"),
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}