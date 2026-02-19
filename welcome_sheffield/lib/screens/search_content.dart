import 'package:flutter/material.dart';
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
    'Waste & Recycling',
    'Roads, Pavements & Transport',
    'Housing & Property',
    'Community & Safety',
    'Emergencies & Severe Weather',
    'Housing & Homeless',
    'Families and Education',
    'Public Spaces',
    'Libraries, learning and help',
    'Health & Care',
    'Benefits and Cost of Living',
    'Events and Tourism',
    'Disability and Accessibility',
    'Legal rights and immigration',
    'Contact Us/Help',
  ];

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
    final t = title.toLowerCase();
    if (t.contains("emergencies")) return ["999", "111", "police", "ambulance", "fire", "weather"];
    if (t.contains("health")) return ["nhs", "gp", "doctor", "hospital", "pharmacy", "care"];
    if (t.contains("housing")) return ["rent", "tenancy", "landlord", "homeless", "shelter"];
    if (t.contains("legal")) return ["visa", "immigration", "rights", "law", "solicitor"];
    if (t.contains("benefits")) return ["uc", "universal credit", "support", "money", "cost"];
    if (t.contains("waste")) return ["bin", "recycling", "rubbish", "trash"];
    return const [];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // the search bar itself
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "Search services, e.g. NHS, housing, 999…",
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
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "No results found",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Try a different keyword (e.g. “NHS”, “visa”, “rent”, “police”).",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),

// filter 
          for (final title in items) _buildListItem(title, context),
        ],
      ),
    );
  }

  Widget _buildListItem(String title, BuildContext context) {
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
          if (title == 'Contact Us/Help') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUsScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(title: title)),
            );
          }
        },
      ),
    );
  }
}
