import 'package:flutter/material.dart';
import 'package:welcome_sheffield/app_state.dart';
import 'detail_page.dart';
import 'contactus_screen.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  final TextEditingController _controller = TextEditingController();
  String _query = "";

  final List<String> _allItems = const [
    'waste',
    'roads',
    'housing',
    'community',
    'emergency',
    'homeless',
    'family',
    'public',
    'library',
    'health',
    'benefits',
    'events',
    'disability',
    'legal',
    'contact',
  ];

  String contentTitleFor(String key) {
    switch (key) {
      case "waste":
        return "Waste & Recycling";
      case "roads":
        return "Roads, Pavements & Transport";
      case "housing":
        return "Housing & Property";
      case "community":
        return "Community & Safety";
      case "emergency":
        return "Emergencies & Severe Weather";
      case "homeless":
        return "Housing & Homeless";
      case "family":
        return "Families and Education";
      case "public":
        return "Public Spaces";
      case "library":
        return "Libraries, learning and help";
      case "health":
        return "Health & Care";
      case "benefits":
        return "Benefits and Cost of Living";
      case "events":
        return "Events and Tourism";
      case "disability":
        return "Disability and Accessibility";
      case "legal":
        return "Legal Rights and Immigration";
      default:
        return key;
    }
  }

  List<String> get _filteredItems {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _allItems;

    return _allItems.where((title) {
      if (title.toLowerCase().contains(q)) return true;

      final keywords = _keywordsFor(title);
      return keywords.any((k) => k.contains(q));
    }).toList();
  }

  List<String> _keywordsFor(String title) {
    if (title == "emergency") return ["999", "111", "police", "fire"];
    if (title == "health") return ["nhs", "gp", "doctor"];
    if (title == "housing") return ["rent", "tenancy"];
    if (title == "legal") return ["visa", "immigration"];
    if (title == "benefits") return ["money", "support"];
    if (title == "waste") return ["bin", "recycling"];
    return const [];
  }

  String titleKey(String key) {
    switch (key) {
      case "waste":
        return "waste";
      case "roads":
        return "roads";
      case "housing":
        return "housing";
      case "community":
        return "community";
      case "emergency":
        return "emergency";
      case "homeless":
        return "homeless";
      case "family":
        return "family";
      case "public":
        return "public";
      case "library":
        return "library";
      case "health":
        return "health";
      case "benefits":
        return "benefits";
      case "events":
        return "events";
      case "disability":
        return "disability";
      case "legal":
        return "legal";
      case "contact":
        return "contact_help";
      default:
        return key;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    final items = _filteredItems;

    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
         
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: appState.tr("search_hint"),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = "");
                        },
                      ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(appState.tr("no_results")),
            ),
          for (final key in items) _buildListItem(key, context),

        ],
      ),
    );
  }

  Widget _buildListItem(String key, BuildContext context) {
    final appState = AppState.of(context);
    final title = appState.tr(titleKey(key));

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          if (key == "contact") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactUsScreen(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(title: contentTitleFor(key)),
              ),
            );
          }
        },
      ),
    );
  }
}