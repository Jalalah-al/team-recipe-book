import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'nearby_map.dart';
import 'live_search_map.dart';
import '../tr_helper.dart';

class MapsContent extends StatefulWidget {
  const MapsContent({super.key});

  @override
  State<MapsContent> createState() => _MapsContentState();
}

class _MapsContentState extends State<MapsContent> {
  LatLng? _currentLocation;
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();
  List<Map> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _currentLocation = const LatLng(53.3811, -1.4701);
        _loading = false;
      });
    }
  }

  void _search(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    List<Map> allPlaces = [
      {'name': 'Sheffield Train Station', 'lat': 53.3781, 'lng': -1.4624, 'category': 'Transport'},
      {'name': 'Meadowhall Interchange', 'lat': 53.4172, 'lng': -1.4118, 'category': 'Transport'},
      {'name': 'City Hall Tram Stop', 'lat': 53.3805, 'lng': -1.4685, 'category': 'Transport'},
      {'name': 'Cathedral Tram Stop', 'lat': 53.3835, 'lng': -1.4680, 'category': 'Transport'},
      {'name': 'University Tram Stop', 'lat': 53.3822, 'lng': -1.4865, 'category': 'Transport'},
      
      {'name': 'Sheffield Town Hall', 'lat': 53.3827, 'lng': -1.4650, 'category': 'Council'},
      {'name': 'Sheffield City Hall', 'lat': 53.3805, 'lng': -1.4685, 'category': 'Council'},
      {'name': 'Howden House (Council HQ)', 'lat': 53.3820, 'lng': -1.4655, 'category': 'Council'},
      {'name': 'Moorfoot Building', 'lat': 53.3775, 'lng': -1.4705, 'category': 'Council'},
      {'name': 'First Point - City Centre', 'lat': 53.3790, 'lng': -1.4690, 'category': 'Council'},
      {'name': 'First Point - Manor Top', 'lat': 53.3680, 'lng': -1.4250, 'category': 'Council'},
      {'name': 'First Point - Upperthorpe', 'lat': 53.3900, 'lng': -1.4900, 'category': 'Council'},
      {'name': 'First Point - Hillsborough', 'lat': 53.4040, 'lng': -1.5030, 'category': 'Council'},
      {'name': 'First Point - Chapeltown', 'lat': 53.4620, 'lng': -1.4660, 'category': 'Council'},
      {'name': 'First Point - Crystal Peaks', 'lat': 53.3380, 'lng': -1.3480, 'category': 'Council'},
      {'name': 'First Point - Stockbridge', 'lat': 53.4300, 'lng': -1.4900, 'category': 'Council'},
      {'name': 'Staniforth Road Depot', 'lat': 53.3850, 'lng': -1.4400, 'category': 'Council'},
      {'name': 'Olive Grove Depot', 'lat': 53.3620, 'lng': -1.4630, 'category': 'Council'},
      {'name': 'Manvers Depot', 'lat': 53.3950, 'lng': -1.3400, 'category': 'Council'},
      
      {'name': 'Endcliffe Park', 'lat': 53.3686, 'lng': -1.5030, 'category': 'Park'},
      {'name': 'Weston Park', 'lat': 53.3820, 'lng': -1.4875, 'category': 'Park'},
      {'name': 'Botanical Gardens', 'lat': 53.3757, 'lng': -1.4825, 'category': 'Park'},
      {'name': 'Graves Park', 'lat': 53.3209, 'lng': -1.4634, 'category': 'Park'},
      {'name': 'Millhouses Park', 'lat': 53.3482, 'lng': -1.5020, 'category': 'Park'},
      
      {'name': 'Northern General Hospital', 'lat': 53.4125, 'lng': -1.4669, 'category': 'Healthcare'},
      {'name': 'Royal Hallamshire Hospital', 'lat': 53.3749, 'lng': -1.4902, 'category': 'Healthcare'},
      {'name': 'Sheffield Children\'s Hospital', 'lat': 53.3745, 'lng': -1.4908, 'category': 'Healthcare'},
      {'name': 'Weston Park Hospital', 'lat': 53.3829, 'lng': -1.4891, 'category': 'Healthcare'},
      
      {'name': 'University of Sheffield', 'lat': 53.3811, 'lng': -1.4882, 'category': 'Education'},
      {'name': 'Sheffield Hallam University', 'lat': 53.3792, 'lng': -1.4649, 'category': 'Education'},
      {'name': 'King Edward VII School', 'lat': 53.3775, 'lng': -1.5050, 'category': 'Education'},
      {'name': 'Notre Dame High School', 'lat': 53.3700, 'lng': -1.5000, 'category': 'Education'},
      {'name': 'Silverdale School', 'lat': 53.3350, 'lng': -1.4950, 'category': 'Education'},
      
      {'name': 'Meadowhall Shopping Centre', 'lat': 53.4170, 'lng': -1.4120, 'category': 'Shopping'},
      {'name': 'The Moor Market', 'lat': 53.3785, 'lng': -1.4710, 'category': 'Shopping'},
      {'name': 'Orchard Square', 'lat': 53.3810, 'lng': -1.4680, 'category': 'Shopping'},
      
      {'name': 'The Botanist', 'lat': 53.3795, 'lng': -1.4695, 'category': 'Restaurant'},
      {'name': 'Kommune', 'lat': 53.3780, 'lng': -1.4685, 'category': 'Restaurant'},
      {'name': 'Sheffield Tap', 'lat': 53.3785, 'lng': -1.4625, 'category': 'Pub'},
      
      {'name': 'Sheffield Central Library', 'lat': 53.3795, 'lng': -1.4680, 'category': 'Library'},
      {'name': 'Crystal Peaks Library', 'lat': 53.3380, 'lng': -1.3480, 'category': 'Library'},
    ];

    setState(() {
      _searchResults = allPlaces.where((place) {
        return place['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  String _translateCategory(BuildContext context, String category) {
    switch (category) {
      case 'Transport':
        return tr(context, 'transport');
      case 'Council':
        return tr(context, 'council');
      case 'Park':
        return tr(context, 'park');
      case 'Healthcare':
        return tr(context, 'healthcare');
      case 'Education':
        return tr(context, 'education');
      case 'Shopping':
        return tr(context, 'shopping');
      case 'Restaurant':
        return tr(context, 'restaurant');
      case 'Pub':
        return tr(context, 'pub');
      case 'Library':
        return tr(context, 'library_place');
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color(0xFF13384A),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(context, 'city_maps'),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      tr(context, 'find_whats_near_you'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  onChanged: _search,
                  decoration: InputDecoration(
                    hintText: tr(context, 'search_for_places'),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),
            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : FlutterMap(
                            options: MapOptions(
                              initialCenter: _currentLocation!,
                              initialZoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.sheffield.app',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: _currentLocation!,
                                    width: 40,
                                    height: 40,
                                    child: const Icon(
                                      Icons.my_location,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            
            // Search Results
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (_searchResults.isNotEmpty) ...[
                      Text(
                      tr(context, 'search_results'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13384A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._searchResults.map((place) => _buildResultCard(place)),
                    const SizedBox(height: 40),
                  ] else if (_searchController.text.isNotEmpty) ...[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text(
                          tr(context, 'no_results_found'),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                  
                  if (_searchResults.isEmpty && _searchController.text.isEmpty) ...[
                    Text(
                      tr(context, 'browse_by_category'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13384A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCategoryButton(Icons.directions_bus, tr(context, 'transport'), 'transport'),
                    _buildCategoryButton(Icons.park, tr(context, 'green_spaces'), 'parks'),
                    _buildCategoryButton(Icons.local_hospital, tr(context, 'healthcare'), 'healthcare'),
                    _buildCategoryButton(Icons.school, tr(context, 'education'), 'education'),
                    _buildCategoryButton(Icons.shopping_cart, tr(context, 'shopping'), 'shopping'),
                    _buildCategoryButton(Icons.restaurant, tr(context, 'food_drink'), 'food'),
                    _buildCategoryButton(Icons.account_balance, tr(context, 'council_buildings'), 'council'),
                    _buildCategoryButton(Icons.search, tr(context, 'search_anything'), 'search'),
                    const SizedBox(height: 40),
                  ],
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(Map place) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(
          _getIconForCategory(place['category']),
          color: const Color(0xFF13384A),
        ),
        title: Text(place['name']),
        subtitle: Text(_translateCategory(context, place['category'])),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NearbyMap(
                placeType: 'all',
                selectedPlace: place,
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Transport':
        return Icons.directions_bus;
      case 'Council':
        return Icons.account_balance;
      case 'Park':
        return Icons.park;
      case 'Healthcare':
        return Icons.local_hospital;
      case 'Education':
        return Icons.school;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Pub':
        return Icons.local_bar;
      case 'Library':
        return Icons.library_books;
      default:
        return Icons.place;
    }
  }

  Widget _buildCategoryButton(IconData icon, String title, String type) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF13384A), size: 28),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          if (type == 'search') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LiveSearchMap(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NearbyMap(placeType: type),
              ),
            );
          }
        },
      ),
    );
  }
}