import 'package:flutter/material.dart';
import '../tr_helper.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  static const Color primaryBlue = Color(0xFF13384A);

  final List<Map<String, dynamic>> items = [
    {"key": "gp", "icon": Icons.local_hospital, "done": false},
    {"key": "emergency_numbers", "icon": Icons.warning, "done": false},
    {"key": "bank", "icon": Icons.account_balance, "done": false},
    {"key": "sim", "icon": Icons.sim_card, "done": false},
    {"key": "supermarket", "icon": Icons.shopping_basket, "done": false},
    {"key": "bins", "icon": Icons.delete_outline, "done": false},
    {"key": "map", "icon": Icons.map_outlined, "done": false},
    {"key": "council_number", "icon": Icons.apartment, "done": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        title: Text(tr(context, "checklist")),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(26),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            Text(
              tr(context, "getting_started"),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...items.map((item) {
              return _ChecklistTile(
                title: tr(context, item["key"]),
                icon: item["icon"],
                value: item["done"],
                onChanged: (v) {
                  setState(() {
                    item["done"] = v;
                  });
                },
              );
            }),

          ],
        ),
      ),
    );
  }
}

class _ChecklistTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final Function(bool?) onChanged;

  const _ChecklistTile({
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.04),
          ),
        ],
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title),
        secondary: Icon(icon, color: const Color(0xFF13384A)),
      ),
    );
  }
}