import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reefs_nav/core/services/fetch_location.dart';
import 'package:reefs_nav/core/services/tileManager/TileProviderModel.dart';
import 'package:reefs_nav/core/services/tileManager/store_tiles.dart';
import 'package:reefs_nav/core/services/tileManager/cached_network_tiles.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;
  late TileManager tileManager;
  late TileProviderModel tileProviderModel;
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    //tileManager = TileManager();
    // tileProviderModel = Provider.of<TileProviderModel>(context, listen: false);
    _fetchCurrentLocation();
  }

  void _fetchCurrentLocation() async {
    LocationService locationService = LocationService();
    Position? position = await locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        mapController.move(currentLocation!, 15.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ;

    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentLocation ??
              LatLng(21.54, 39.16), // Initial center of the map
          initialZoom: 15.0, // Initial zoom level
        ), // MapOptions
        children: [
          TileLayer(
            tileProvider: CachedNetworkTileProvider(
                "https://api.mapbox.com/styles/v1/yorhaether/clrnqwwd9006g01peerp97p8m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoieW9yaGFldGhlciIsImEiOiJjbHJ4ZjI4ajQwdXZ6Mmp0a3pzZmlxaTloIn0.yiGEwb2lvrqZRFB1QixSYw"),
            urlTemplate:
                'https://api.mapbox.com/styles/v1/yorhaether/clrnqwwd9006g01peerp97p8m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoieW9yaGFldGhlciIsImEiOiJjbHJ4ZjI4ajQwdXZ6Mmp0a3pzZmlxaTloIn0.yiGEwb2lvrqZRFB1QixSYw',
            additionalOptions: const {
              'accessToken':
                  'pk.eyJ1IjoieW9yaGFldGhlciIsImEiOiJjbHJ4ZjI4ajQwdXZ6Mmp0a3pzZmlxaTloIn0.yiGEwb2lvrqZRFB1QixSYw',
              'id': 'yorhaether.6vwpkduq',
            },
            // tileProvider: localTileProvider,
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 48.0,
                height: 48.0,
                point: currentLocation ?? const LatLng(20.0, 38.0),
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      Container(
                        width: 18.0,
                        height: 18.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70.0, right: 9.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF262626),
        ),
        child: IconButton(
          icon: const Icon(Icons.my_location_outlined),
          color: Colors.white,
          onPressed: () {
            _fetchCurrentLocation();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}