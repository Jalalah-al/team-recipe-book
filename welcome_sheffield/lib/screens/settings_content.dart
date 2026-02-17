import 'package:flutter/material.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          
          
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13384A),
            ),
          ),
          const SizedBox(height: 30),
          
         
          _buildSettingsSection('App Preferences', [
            _buildSettingItem(Icons.language, 'Language', 'English'),
            _buildSettingItem(Icons.dark_mode, 'Dark Mode', 'Off'),
            _buildSettingItem(Icons.notifications, 'Notifications', 'On'),
          ]),
          
          const SizedBox(height: 20),
          

          _buildSettingsSection('Accessibility', [
            _buildSettingItem(Icons.volume_up, 'Text to Speech', 'Off'),
            _buildSettingItem(Icons.contrast, 'High Contrast', 'Off'),
            _buildSettingItem(Icons.font_download, 'Large Text', 'Off'),
          ]),
          
          const SizedBox(height: 20),
          
        
          _buildSettingsSection('About', [
            _buildSettingItem(Icons.info, 'App Version', '1.0.0'),
            _buildSettingItem(Icons.privacy_tip, 'Privacy Policy', ''),
            _buildSettingItem(Icons.support_agent, 'Contact Support', ''),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 2,
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF13384A)),
      title: Text(title),
      trailing: value.isNotEmpty 
        ? Text(
            value,
            style: TextStyle(color: Colors.grey.shade600),
          )
        : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        
      },
    );
  }
}