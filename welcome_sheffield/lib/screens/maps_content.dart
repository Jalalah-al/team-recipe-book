import 'package:flutter/material.dart';

class MapsContent extends StatelessWidget {
  const MapsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          
          const Text(
            'City Maps',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13384A),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Find your way around Sheffield',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          
          
          _buildMapCategory(Icons.map, 'Street Map', 'View city streets'),
          _buildMapCategory(Icons.directions_bus, 'Transport Map', 'Buses, trams and trains'),
          _buildMapCategory(Icons.park, 'Green Spaces', 'Parks and nature reserves'),
          _buildMapCategory(Icons.local_hospital, 'Healthcare Map', 'Hospitals and clinics'),
          _buildMapCategory(Icons.school, 'Education Map', 'Schools and universities'),
        ],
      ),
    );
  }

  Widget _buildMapCategory(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF13384A), size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          
        },
      ),
    );
  }
}