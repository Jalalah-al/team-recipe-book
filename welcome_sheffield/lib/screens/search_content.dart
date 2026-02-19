import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'contactus_screen.dart'; 

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildListItem('Waste & Recycling', context),
          _buildListItem('Roads, Pavements & Transport', context),
          _buildListItem('Housing & Property', context),
          _buildListItem('Community & Safety', context),
          _buildListItem('Emergencies & Severe Weather', context),
          _buildListItem('Housing & Homeless', context),
          _buildListItem('Families and Education', context),
          _buildListItem('Public Spaces', context),
          _buildListItem('Libraries, learning and help', context),
          _buildListItem('Health & Care', context),
          _buildListItem('Benefits and Cost of Living', context),
          _buildListItem('Events and Tourism', context),
          _buildListItem('Disability and Accessibility', context),
          _buildListItem('Legal rights and immigration', context),
          _buildListItem('Contact Us/Help', context),
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
        title: Text(title, style: const TextStyle(fontSize: 16, color: Colors.black87)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          
          if (title == 'Contact Us/Help') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactUsScreen(),
              ),
            );
          } else {
            // For all other items, go to detail page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(title: title),
              ),
            );
          }
        },
      ),
    );
  }
}