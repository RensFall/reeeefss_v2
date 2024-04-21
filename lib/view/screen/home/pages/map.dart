import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reefs_nav/core/services/fetch_location.dart';
import 'package:reefs_nav/core/services/tileManager/TileProviderModel.dart';
import 'package:reefs_nav/core/services/tileManager/cached_network_tiles.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;
  late TileProviderModel tileProviderModel;
  LatLng? currentLocation;
  List<LatLng> points = []; // this will store the points of interest

  @override
  void initState() {
    super.initState();
    mapController = MapController();

    _fetchCurrentLocation();
  }

  void _addPoint(LatLng point) {
    setState(() {
      points.add(point);
    });
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
          initialCenter: currentLocation ?? const LatLng(22.75, 38.98),
          initialZoom: 12.0,
          minZoom: 5.0,
          maxZoom: 22,
          initialCameraFit: CameraFit.bounds(
            bounds: LatLngBounds(
              const LatLng(-85.0, -180.0),
              const LatLng(85.0, 180.0),
            ),
            // padding: EdgeInsets.all(8.0),
          ),

          onTap: (_, latlng) => _addPoint(latlng), // add point on tap.
        ),
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
          ),
          MarkerLayer(
            markers: _buildMarkers(),
          ),
          PolylineLayer(polylines: [
            Polyline(
              points: points,
              strokeWidth: 4.0,
              color: Colors.blue,
            )
          ])
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

  List<Marker> _buildMarkers() {
    List<Marker> allMarkers = [];

    // Marker for the current location, if it exists
    if (currentLocation != null) {
      allMarkers.add(Marker(
        width: 48.0,
        height: 48.0,
        point: currentLocation!,
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
              ),
              Container(
                width: 18.0,
                height: 18.0,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
              ),
            ],
          ),
        ),
      ));
    }

    // Markers for all other points
    for (LatLng point in points) {
      allMarkers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: point,
        child: GestureDetector(
          onTap: () {
            _confirmPointDeletion(point);
          },
          child: const Icon(Icons.location_on, color: Colors.red, size: 48.0),
        ),
      ));
    }

    return allMarkers;
  }

  void _confirmPointDeletion(LatLng point) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text("Confirm Deletion"),
          content: const Text("Do you want to remove this marker?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                setState(() {
                  points.remove(point); // Remove the point from the list
                  Navigator.of(context).pop(); // Close the dialog
                });
              },
            ),
          ],
        );
      },
    );
  }
}
