import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import 'package:vector_math/vector_math.dart';

double haversine(double lon1, double lat1, double lon2, double lat2) {
  // Convert latitude and longitude from degrees to radians
  List<double> radiansList =
      [lon1, lat1, lon2, lat2].map((value) => radians(value)).toList();

  // Extracting the values after conversion
  lon1 = radiansList[0];
  lat1 = radiansList[1];
  lon2 = radiansList[2];
  lat2 = radiansList[3];

  // Haversine formula
  double dlon = lon2 - lon1;
  double dlat = lat2 - lat1;
  double a = math.pow(math.sin(dlat / 2), 2) +
      math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlon / 2), 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  double radiusOfEarth =
      3440.065; // Radius of Earth in nautical miles (6371 km)
  double distance = radiusOfEarth * c;
  return distance;
}

double calculateTotalDistance(List<LatLng> points) {
  double totalDistance = 0;

  // Iterate over the points pairwise
  for (int i = 0; i < points.length - 1; i++) {
    LatLng point1 = points[i];
    LatLng point2 = points[i + 1];
    double distance = haversine(
        point1.longitude, point1.latitude, point2.longitude, point2.latitude);
    totalDistance += distance;
  }

  return totalDistance;
}

double calculateFuelConsumption(List<LatLng> points) {
  double totalDistanceNm = calculateTotalDistance(points);
  double consumptionRate =
      8.0; // Example consumption rate in nautical miles per gallon
  double fuelNeeded = totalDistanceNm / consumptionRate;
  print(
      'The boat will need approximately ${fuelNeeded.toStringAsFixed(2)} gallons of fuel for the trip.');
  return fuelNeeded;
}
