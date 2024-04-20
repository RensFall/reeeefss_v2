import 'package:flutter_map/flutter_map.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkTileProvider extends TileProvider {
  final String urlTemplate;

  CachedNetworkTileProvider(this.urlTemplate);

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    debugPrint("Cached Network Tile Provider is running");
    var url = _getTileUrl(coordinates, options);
    return CachedNetworkImageProvider(url);
  }

  String _getTileUrl(TileCoordinates coords, TileLayer options) {
    return urlTemplate
        .replaceAll('{z}', coords.z.toInt().toString())
        .replaceAll('{x}', coords.x.toInt().toString())
        .replaceAll('{y}', coords.y.toInt().toString());
  }
}
