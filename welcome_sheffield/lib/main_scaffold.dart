import 'package:flutter/material.dart';
import 'screens/home_content.dart';
import 'screens/search_content.dart';
import 'screens/maps_content.dart';
import 'screens/settings_content.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  
  const MainScaffold({
    super.key, 
    required this.child,
    this.currentIndex = 0,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    
    Widget content;
    switch (index) {
      case 0:
        content = const HomeContent();
        break;
      case 1:
        content = const SearchContent();
        break;
      case 2:
        content = const MapsContent();
        break;
      case 3:
        content = const SettingsContent();
        break;
      default:
        content = const HomeContent();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScaffold(
          child: content,
          currentIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Sheffield Hallam University',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xFF13384A),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 48, 
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {},
            padding: EdgeInsets.zero, 
            constraints: const BoxConstraints(), 
          ),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF13384A),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Maps'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}