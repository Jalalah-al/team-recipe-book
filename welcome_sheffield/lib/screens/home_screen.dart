import 'dart:async';
import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'content.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryBlue = Color(0xFF13384A);
  final PageController _pageController = PageController();
  Timer? _timer;
  int _pageIndex = 0;


  final List<_BannerItem> banners = const [
    _BannerItem(
      title: "Today’s tip",
      subtitle: "Register with a GP as soon as you can.",
      icon: Icons.local_hospital,
    ),
    _BannerItem(
      title: "Bins reminder",
      subtitle: "Check collection day for your postcode.",
      icon: Icons.delete_outline,
    ),
    _BannerItem(
      title: "Emergency info",
      subtitle: "999 for emergencies, 101 for non-emergency police.",
      icon: Icons.warning_amber_rounded,
    ),
  ];

  final List<_Feature> quickFeatures = const [
    _Feature(title: "Emergency", icon: Icons.emergency, route: "/sos"),
    _Feature(title: "Healthcare", icon: Icons.local_hospital, route: "/health"),
    _Feature(title: "Bins", icon: Icons.delete_outline, route: "/bins"),
    _Feature(title: "Transport", icon: Icons.directions_bus, route: "/transport"),
    _Feature(title: "Weather", icon: Icons.cloud, route: "/weather"),
    _Feature(title: "Map", icon: Icons.map_outlined, route: "/map"),
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      _pageIndex = (_pageIndex + 1) % banners.length;
      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
  
  @override
    Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
            top: Radius.circular(26),
            ),
        ),
        child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
                const Text(
                    "Welcome to Sheffield",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
            _buildBanner(),
            const SizedBox(height: 18),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Text(
                    "Quick Access",
                    style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    ),
                ),
                TextButton(
                    onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                            const CategoriesScreen(),
                        ),
                    );
                    },
                    child: const Text("More"),
                ),
                ],
            ),

            const SizedBox(height: 10),

            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quickFeatures.length + 1,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                if (index == quickFeatures.length) {
                    return _MoreTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                            const CategoriesScreen(),
                        ),
                    ),
                    );
                }

                final f = quickFeatures[index];

                return _FeatureTile(
                    title: f.title,
                    icon: f.icon,
                    onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CategoriesScreen(),
                    ),
                    ),
                );
                },
            ),
            ],
        ),
        ),
    );
    }


  Widget _buildBanner() {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: _pageController,
        itemCount: banners.length,
        onPageChanged: (i) => _pageIndex = i,
        itemBuilder: (context, i) {
          final b = banners[i];
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(b.icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        b.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BannerItem {
  final String title;
  final String subtitle;
  final IconData icon;
  const _BannerItem({required this.title, required this.subtitle, required this.icon});
}

class _Feature {
  final String title;
  final IconData icon;
  final String route;
  const _Feature({required this.title, required this.icon, required this.route});
}

class _FeatureTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _FeatureTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF13384A), size: 30),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  final VoidCallback onTap;
  const _MoreTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade100,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.grid_view_rounded, color: Color(0xFF13384A), size: 30),
            Spacer(),
            Text("More", style: TextStyle(fontWeight: FontWeight.w700)),
            Text("All categories", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
