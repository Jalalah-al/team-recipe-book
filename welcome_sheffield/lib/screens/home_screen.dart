import 'dart:async';
import 'package:flutter/material.dart';
import '../tr_helper.dart';
import 'checklist_screen.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int)? onNavigateToTab;

  const HomeScreen({super.key, this.onNavigateToTab});

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
      titleKey: "today_tip",
      subtitleKey: "gp_register_tip",
      icon: Icons.local_hospital,
      imagePath: "lib/images/GP.jpeg",
    ),
    _BannerItem(
      titleKey: "bins_reminder",
      subtitleKey: "bins_postcode_tip",
      icon: Icons.delete_outline,
      imagePath: "lib/images/bins.jpeg",
    ),
    _BannerItem(
      titleKey: "emergency_info",
      subtitleKey: "emergency_numbers_tip",
      icon: Icons.warning_amber_rounded,
      imagePath: "lib/images/emergency.jpeg",
    ),
  ];

  final List<_Feature> quickFeatures = const [
    _Feature(titleKey: "emergency", icon: Icons.emergency, route: "/sos"),
    _Feature(titleKey: "healthcare", icon: Icons.local_hospital, route: "/health"),
    _Feature(titleKey: "bins", icon: Icons.delete_outline, route: "/bins"),
    _Feature(titleKey: "checklist", icon: Icons.checklist_rounded, route: "/checklist"),
    _Feature(titleKey: "map", icon: Icons.map_outlined, route: "/map"),
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
            Text(
              tr(context, "welcome"),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            _buildBanner(),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr(context, "quick_access"),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onNavigateToTab?.call(1);
                  },
                  child: Text(tr(context, "more")),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quickFeatures.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index) {
                if (index == quickFeatures.length) {
                  return _MoreTile(
                    onTap: () {
                      widget.onNavigateToTab?.call(1);
                    },
                  );
                }

                final f = quickFeatures[index];

                return _FeatureTile(
                  title: tr(context, f.titleKey),
                  icon: f.icon,
                  onTap: () {
                    if (f.route == "/checklist") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChecklistScreen(),
                        ),
                      );
                    } else if (f.route == "/map") {
                      widget.onNavigateToTab?.call(2);
                    } else {
                      widget.onNavigateToTab?.call(1);
                    }
                  },
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
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      b.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.45),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
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
                                tr(context, b.titleKey),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                tr(context, b.subtitleKey),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.88),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BannerItem {
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  final String imagePath;

  const _BannerItem({
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.imagePath,
  });
}

class _Feature {
  final String titleKey;
  final IconData icon;
  final String route;

  const _Feature({
    required this.titleKey,
    required this.icon,
    required this.route,
  });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.grid_view_rounded, color: Color(0xFF13384A), size: 30),
            const Spacer(),
            Text(
              tr(context, "more"),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              tr(context, "all_categories"),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}