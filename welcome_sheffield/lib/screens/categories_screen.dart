import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: const Text(
          'All Categories',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Color(0xFF13384A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Language selection coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'Select Language',
          ),
          const SizedBox(width: 8), 
        ],
      ),

      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            _buildListItem('Waste & Recycling'),
            _buildListItem('Roads, Pavements & Transport'),
            _buildListItem('Housing & Property'),
            _buildListItem('Community & Safety'),
            _buildListItem('Emergencies & Severe Weather'),
            _buildListItem('Housing & Homeless'),
            _buildListItem('Families and Education'),
            _buildListItem('Public Spaces'),
            _buildListItem('Libraries, learning and help'),
            _buildListItem('Health & Care'),
            _buildListItem('Benefits and Cost of Living'),
            _buildListItem('Events and Tourism'),
            _buildListItem('Disability and Accessibility'),
            _buildListItem('Legal rights and immigration'),
            _buildListItem('Contact Us/Help'),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,  
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
        onTap: () {
          
        },
      ), 
    );
  }
}