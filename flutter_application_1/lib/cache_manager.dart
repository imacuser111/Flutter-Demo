import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:typed_data';
import 'package:from_css_color/from_css_color.dart'

class CacheManager {
  final defaultCacheManager = DefaultCacheManager();

  get getCachedNetworkImage => null;

  Future<String> cacheImage(String imagePath) async {
    // Check if the image file is not in the cache
    if ((await defaultCacheManager.getFileFromCache(imagePath))?.file == null) {

        // Put the image file in the cache
        await defaultCacheManager.putFile(
          imagePath,
          Uint8List(10000000),
          fileExtension: "jpg",
        );
    }

    // Return image download url
    return imagePath;
  }
}
