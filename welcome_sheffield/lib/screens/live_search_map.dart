import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LiveSearchMap extends StatefulWidget {
  const LiveSearchMap({super.key});

  @override
  State<LiveSearchMap> createState() => _LiveSearchMapState();
}

class _LiveSearchMapState extends State<LiveSearchMap> {
  LatLng? _myLocation;
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  List<Marker> _markers = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition();
      setState(() {
        _myLocation = LatLng(pos.latitude, pos.longitude);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _myLocation = const LatLng(53.3811, -1.4701);
        _loading = false;
      });
    }
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final url = 'https://nominatim.openstreetmap.org/search?'
        'q=${Uri.encodeComponent(query)}'
        '&format=json'
        '&limit=30'
        '&addressdetails=1'
        '&bounded=1'
        '&viewbox=-1.65,53.45,-1.35,53.32'
        '&zoom=18';
    
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'SheffieldCityApp/1.0'},
      );
      
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        setState(() {
          _searchResults = data.map((item) => {
            'name': item['display_name'],
            'lat': double.parse(item['lat']),
            'lng': double.parse(item['lon']),
            'type': item['type'],
            'category': item['category'] ?? 'place',
          }).toList();
          _isSearching = false;
        });
      }
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _goToPlace(Map<String, dynamic> place) {
    final LatLng location = LatLng(place['lat'], place['lng']);
    
    setState(() {
      _markers = [
        Marker(
          point: location,
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Type: ${place['type']}'),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF13384A),
                          ),
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.place,
              color: Colors.blue,
              size: 35,
            ),
          ),
        ),
      ];
      _searchResults = [];
      _searchController.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('📍 ${place['name']}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Sheffield'),
        backgroundColor: const Color(0xFF13384A),
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchPlaces,
              decoration: InputDecoration(
                hintText: 'Search anything... cafes, shops, parks, hospitals',
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults = [];
                            _markers = [];
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _myLocation!,
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.sheffield.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _myLocation!,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  ..._markers,
                ],
              ),
            ],
          ),
          
          if (_isSearching)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          
          if (_searchResults.isNotEmpty)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.all(8),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final place = _searchResults[index];
                    return ListTile(
                      title: Text(
                        place['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        '${place['type']} • ${place['category']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      leading: _getIconForType(place['type']),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _goToPlace(place),
                    );
                  },
                ),
              ),
            ),
          
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                setState(() {
                  _markers = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cleared markers')),
                );
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.clear, color: Color(0xFF13384A), size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconForType(String type) {
    IconData icon;
    if (type.contains('hospital') || type.contains('clinic')) {
      icon = Icons.local_hospital;
    } else if (type.contains('school') || type.contains('university')) {
      icon = Icons.school;
    } else if (type.contains('park') || type.contains('garden')) {
      icon = Icons.park;
    } else if (type.contains('restaurant') || type.contains('cafe')) {
      icon = Icons.restaurant;
    } else if (type.contains('shop')) {
      icon = Icons.shopping_cart;
    } else if (type.contains('station') || type.contains('bus') || type.contains('tram')) {
      icon = Icons.directions_bus;
    } else {
      icon = Icons.place;
    }
    return Icon(icon, color: const Color(0xFF13384A), size: 24);
  }
}