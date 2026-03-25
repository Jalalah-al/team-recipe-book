import 'package:flutter/material.dart';
import 'package:welcome_sheffield/app_state.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),

          Text(
            appState.tr('settings_title'),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13384A),
            ),
          ),

          const SizedBox(height: 30),

          _buildSettingsSection(
            context,
            appState.tr('app_preferences'),
            [
              _buildSettingItem(
                context,
                Icons.language,
                appState.tr('language'),
                "English",
              ),
              _buildSettingItem(
                context,
                Icons.dark_mode,
                appState.tr('dark_mode'),
                "Off",
              ),
              _buildSettingItem(
                context,
                Icons.notifications,
                appState.tr('notifications'),
                "On",
              ),
            ],
          ),

          const SizedBox(height: 20),

          _buildSettingsSection(
            context,
            appState.tr('accessibility'),
            [
              _buildSettingItem(
                context,
                Icons.volume_up,
                appState.tr('text_to_speech'),
                "Off",
              ),
              _buildSettingItem(
                context,
                Icons.contrast,
                appState.tr('high_contrast'),
                "Off",
              ),
              _buildSettingItem(
                context,
                Icons.font_download,
                appState.tr('large_text'),
                "Off",
              ),
            ],
          ),

          const SizedBox(height: 20),

          _buildSettingsSection(
            context,
            appState.tr('about'),
            [
              _buildSettingItem(
                context,
                Icons.info,
                appState.tr('app_version'),
                "1.0.0",
              ),
              _buildSettingItem(
                context,
                Icons.privacy_tip,
                appState.tr('privacy_policy'),
                "",
              ),
              _buildSettingItem(
                context,
                Icons.support_agent,
                appState.tr('contact_support'),
                "",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
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

  Widget _buildSettingItem(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF13384A)),
      title: Text(title),
      trailing: value.isNotEmpty
          ? Text(
              value,
              style: TextStyle(color: Colors.grey.shade600),
            )
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}