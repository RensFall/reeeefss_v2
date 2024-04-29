import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

const String apiKey =
    '43c44289746763d40ebd7d164fb6de78'; 
const String baseUrl = 'https://api.openweathermap.org/data/2.5';


Future<Map<String, dynamic>> fetchWeatherData(
    double latitude, double longitude) async {
  final url = Uri.parse(
      '$baseUrl/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load weather data');
  }
}


class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Map<String, dynamic> weatherData;
  bool isLoading = true;
  Location location = new Location();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true; 
    });

    try {
      var userLocation = await location.getLocation();
      if (userLocation.latitude != null && userLocation.longitude != null) {
        final data = await fetchWeatherData(
            userLocation.latitude!, userLocation.longitude!);
        setState(() {
          weatherData = data;
          weatherData['wind']['speed'] =
              convertWindSpeed(weatherData['wind']['speed']);
          isLoading = false; // Hide loading spinner after fetching data
        });
      } else {
        const Text(
            'Could not get your current location to fetch weather data.');
        setState(() {
          isLoading = false;
        });
        throw Exception('Current location not available.');
      }
    } catch (e) {
      debugPrint('Failed to get weather data: $e');
      setState(() {
        isLoading = false; 
      });
    }
  }

  double convertWindSpeed(double speedInMetersPerSecond) {
    return speedInMetersPerSecond * 3.6; // Convert m/s to km/h
  }

  String formatVisibility(int visibilityInMeters) {
    // Convert and format visibility
    return visibilityInMeters >= 1000
        ? '${(visibilityInMeters / 1000).toStringAsFixed(1)} km'
        : '$visibilityInMeters m';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (weatherData.isEmpty) {
      return const Center(child: Text('No weather data available.'));
    }

    var windSpeedIcon = Icons.wind_power;
    var windDirectionIcon = Icons.explore;
    var humidity = Icons.grain;
    var visibility = Icons.visibility;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Current weather of the area",
                style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Row(
                children: [
                  Text(
                    '${weatherData['main']['temp']}°',
                    style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(windDirectionIcon,
                      size: 24, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Wind Direction: ${weatherData['wind']['deg']} degrees',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(windSpeedIcon,
                      size: 24, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Wind Speed: ${weatherData['wind']['speed'].toStringAsFixed(2)} km/h',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    humidity,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Humidity: ${weatherData['main']['humidity']}%',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(visibility,
                      size: 24, color: Theme.of(context).primaryColor),
                  Text(
                    '  Visibility:${formatVisibility(weatherData['visibility'])}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 8.0,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
