import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class NearbyMap extends StatefulWidget {
  final String placeType;
  final Map? selectedPlace;
  
  const NearbyMap({
    super.key, 
    required this.placeType,
    this.selectedPlace,
  });

  @override
  State<NearbyMap> createState() => _NearbyMapState();
}

class _NearbyMapState extends State<NearbyMap> {
  LatLng? _myLocation;
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();
  List<Map> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
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

  void _search(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    List<Map> allPlaces = _getAllPlaces();
    
    setState(() {
      _searchResults = allPlaces.where((place) {
        return place['name'].toLowerCase().contains(query.toLowerCase()) ||
               place['category'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  List<Map> _getAllPlaces() {
    return [
      // Transport
      {'name': 'Sheffield Train Station', 'lat': 53.3781, 'lng': -1.4624, 'category': 'Transport'},
      {'name': 'Meadowhall Interchange', 'lat': 53.4172, 'lng': -1.4118, 'category': 'Transport'},
      {'name': 'City Hall Tram Stop', 'lat': 53.3805, 'lng': -1.4685, 'category': 'Transport'},
      {'name': 'Cathedral Tram Stop', 'lat': 53.3835, 'lng': -1.4680, 'category': 'Transport'},
      {'name': 'University Tram Stop', 'lat': 53.3822, 'lng': -1.4865, 'category': 'Transport'},
      {'name': 'Hillsborough Interchange', 'lat': 53.4032, 'lng': -1.5020, 'category': 'Transport'},
      
      // Council Buildings
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
      
      // Parks
      {'name': 'Endcliffe Park', 'lat': 53.3686, 'lng': -1.5030, 'category': 'Park'},
      {'name': 'Weston Park', 'lat': 53.3820, 'lng': -1.4875, 'category': 'Park'},
      {'name': 'Botanical Gardens', 'lat': 53.3757, 'lng': -1.4825, 'category': 'Park'},
      {'name': 'Graves Park', 'lat': 53.3209, 'lng': -1.4634, 'category': 'Park'},
      {'name': 'Millhouses Park', 'lat': 53.3482, 'lng': -1.5020, 'category': 'Park'},
      {'name': 'Hillsborough Park', 'lat': 53.4038, 'lng': -1.5080, 'category': 'Park'},
      {'name': 'Norfolk Park', 'lat': 53.3720, 'lng': -1.4550, 'category': 'Park'},
      
      // Healthcare
      {'name': 'Northern General Hospital', 'lat': 53.4125, 'lng': -1.4669, 'category': 'Healthcare'},
      {'name': 'Royal Hallamshire Hospital', 'lat': 53.3749, 'lng': -1.4902, 'category': 'Healthcare'},
      {'name': 'Sheffield Children\'s Hospital', 'lat': 53.3745, 'lng': -1.4908, 'category': 'Healthcare'},
      {'name': 'Weston Park Hospital', 'lat': 53.3829, 'lng': -1.4891, 'category': 'Healthcare'},
      {'name': 'Sheffield NHS Walk-in Centre', 'lat': 53.3775, 'lng': -1.4670, 'category': 'Healthcare'},
      
      // Education
      {'name': 'University of Sheffield', 'lat': 53.3811, 'lng': -1.4882, 'category': 'Education'},
      {'name': 'Sheffield Hallam University', 'lat': 53.3792, 'lng': -1.4649, 'category': 'Education'},
      {'name': 'King Edward VII School', 'lat': 53.3775, 'lng': -1.5050, 'category': 'Education'},
      {'name': 'Notre Dame High School', 'lat': 53.3700, 'lng': -1.5000, 'category': 'Education'},
      {'name': 'Sheffield College - City Campus', 'lat': 53.3765, 'lng': -1.4695, 'category': 'Education'},
      
      // Shops
      {'name': 'Meadowhall Shopping Centre', 'lat': 53.4170, 'lng': -1.4120, 'category': 'Shopping'},
      {'name': 'The Moor Market', 'lat': 53.3785, 'lng': -1.4710, 'category': 'Shopping'},
      {'name': 'Orchard Square', 'lat': 53.3810, 'lng': -1.4680, 'category': 'Shopping'},
      
      // Restaurants
      {'name': 'The Botanist', 'lat': 53.3795, 'lng': -1.4695, 'category': 'Restaurant'},
      {'name': 'Kommune', 'lat': 53.3780, 'lng': -1.4685, 'category': 'Restaurant'},
      {'name': 'Sheffield Tap', 'lat': 53.3785, 'lng': -1.4625, 'category': 'Pub'},
    ];
  }

  List<Map> _getPlaces() {
    if (widget.selectedPlace != null) {
      return [widget.selectedPlace!];
    }
    
    switch (widget.placeType) {
      case 'transport':
        return _getAllPlaces().where((p) => p['category'] == 'Transport').toList();
      case 'council':
        return _getAllPlaces().where((p) => p['category'] == 'Council').toList();
      case 'parks':
        return _getAllPlaces().where((p) => p['category'] == 'Park').toList();
      case 'healthcare':
        return _getAllPlaces().where((p) => p['category'] == 'Healthcare').toList();
      case 'education':
        return _getAllPlaces().where((p) => p['category'] == 'Education').toList();
      case 'shops':
        return _getAllPlaces().where((p) => p['category'] == 'Shopping').toList();
      case 'food':
        return _getAllPlaces().where((p) => p['category'] == 'Restaurant' || p['category'] == 'Pub').toList();
      default:
        return _getAllPlaces();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    List<Marker> markers = [];

    // Your location
    markers.add(
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
    );

    // Places to show
    List<Map> placesToShow = _searchResults.isEmpty ? _getPlaces() : _searchResults;
    
    for (var place in placesToShow) {
      markers.add(
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
            child: Icon(
              _getIconForCategory(place['category']),
              color: Colors.blue,
              size: 28,
            ),
          ),
        ),
      );
    }

    String title;
    if (widget.selectedPlace != null) {
      title = widget.selectedPlace!['name'];
    } else {
      switch (widget.placeType) {
        case 'transport':
          title = 'Transport';
          break;
        case 'council':
          title = 'Council Buildings';
          break;
        case 'parks':
          title = 'Green Spaces';
          break;
        case 'healthcare':
          title = 'Healthcare';
          break;
        case 'education':
          title = 'Education';
          break;
        case 'shops':
          title = 'Shops';
          break;
        case 'food':
          title = 'Food & Drink';
          break;
        default:
          title = 'Map';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF13384A),
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search places...',
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
      body: Column(
        children: [
          if (_searchResults.isNotEmpty)
            Container(
              height: 150,
              color: Colors.white,
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchResults[index]['name']),
                    subtitle: Text(_searchResults[index]['category']),
                    leading: Icon(_getIconForCategory(_searchResults[index]['category'])),
                    onTap: () {
                      setState(() {
                        _searchController.clear();
                        _searchResults = [];
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(_searchResults[index]['name'])),
                      );
                    },
                  );
                },
              ),
            ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _myLocation!,
                initialZoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.sheffield.app',
                ),
                MarkerLayer(markers: markers),
              ],
            ),
          ),
        ],
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
      default:
        return Icons.place;
    }
  }
}