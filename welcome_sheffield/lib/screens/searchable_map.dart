import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchableMap extends StatefulWidget {
  const SearchableMap({super.key});

  @override
  State<SearchableMap> createState() => _SearchableMapState();
}

class _SearchableMapState extends State<SearchableMap> {
  LatLng? _myLocation;
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  List<Marker> _markers = [];

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
      });
      return;
    }

    final url = 'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=20&addressdetails=1&bounded=1&viewbox=-1.6,53.45,-1.35,53.35&bounded=1';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        setState(() {
          _searchResults = data.map((item) => {
            'name': item['display_name'],
            'lat': double.parse(item['lat']),
            'lng': double.parse(item['lon']),
            'type': item['type'],
          }).toList();
        });
      }
    } catch (e) {
      print('Search error: $e');
    }
  }

  void _addMarkerToMap(Map<String, dynamic> place) {
    setState(() {
      _markers = [
        Marker(
          point: LatLng(place['lat'], place['lng']),
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(place['name'])),
              );
            },
            child: const Icon(
              Icons.place,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ),
      ];
    });
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
        title: const Text('Search Anywhere'),
        backgroundColor: const Color(0xFF13384A),
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchPlaces,
              decoration: InputDecoration(
                hintText: 'Search: hospital, school, park, cafe...',
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
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
          if (_searchResults.isNotEmpty)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.all(8),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
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
                      ),
                      subtitle: Text(place['type']),
                      leading: const Icon(Icons.location_on, color: Colors.blue),
                      onTap: () {
                        _addMarkerToMap(place);
                        setState(() {
                          _searchResults = [];
                          _searchController.clear();
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _markers = [];
                });
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.clear, color: Color(0xFF13384A)),
            ),
          ),
        ],
      ),
    );
  }
}