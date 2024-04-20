import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong2/latlong.dart';

// this class still not used anywhere, I'll make use of it later
class MapControllerProvider with ChangeNotifier {
  late MapController _mapController;

  MapControllerProvider() {
    _mapController = MapController();
  }
  MapController get mapController => _mapController;
}
