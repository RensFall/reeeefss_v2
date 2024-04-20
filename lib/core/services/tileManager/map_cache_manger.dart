import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageCacheManager extends CacheManager {
  static const key = 'customCacheKey';

  static final ImageCacheManager _instance = ImageCacheManager._();

  factory ImageCacheManager() {
    return _instance;
  }

  ImageCacheManager._()
      : super(Config(
          key,
          stalePeriod: const Duration(days: 30),
          maxNrOfCacheObjects: 2000,
          fileService:
              HttpFileService(), // Uses the HttpFileService to retrieve files over HTTP
        ));

  Future<String> getFilePath() async {
    var dir = await getTemporaryDirectory();
    return p.join(dir.path, key);
  }
}
