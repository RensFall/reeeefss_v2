//!!!!!!!!!!
// do not modify or change anything of this file, I'm not done with it yet.
// -Ether
//!!!!!!!!!!
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reefs_nav/core/services/tileManager/TileProviderModel.dart';
import 'store_tiles.dart';

class LocalTileProvider extends TileProvider {
  final TileManager _tileManager;
  final TileProviderModel _tileProviderModel;
  final String urlTemplate;
  final Map<String, ImageProvider> _cache = {};
  LocalTileProvider(
      this._tileManager, this.urlTemplate, this._tileProviderModel);

  @override
  ImageProvider getImage(TileCoordinates coords, TileLayer options) {
    String key = "${coords.z}_${coords.x}_${coords.y}";

    // Attempt to return a cached image if available
    Future<File?> tileFileFuture =
        _tileManager.getTileFile(coords.x, coords.y, coords.z);
    tileFileFuture.then((file) {
      if (file != null) {
        _cache[key] = FileImage(file);
        _tileProviderModel.notifyMapRefresh(); // notify to refresh the map.
      }
    });
    return _cache[key] ??
        _getPlaceholderImage(); // return cached image when availabe or transparrent image if not.
  }

  // Returns a placeholder or transparent image
  ImageProvider _getPlaceholderImage() {
    return MemoryImage(kTransparentImage);
  }

  // this decodes a transparrent image to be returned
  static final Uint8List kTransparentImage = Base64Decoder().convert(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wQAnQEB/wl8UmgAAAAASUVORK5CYII=');
}
