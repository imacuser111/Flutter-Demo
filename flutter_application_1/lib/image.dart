import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'cache_manager.dart';

// 取得APP中圖片
Image getAssetImage(String path) {
  return Image.asset(
    path,
    errorBuilder: (context, error, stackTrace) {
      return const Center(
        child: FlutterLogo(),
      );
    },
    width: 200,
    height: 200,
    fit: BoxFit.contain,
  );
}

// 取得網路的圖片
Image getNetworkImage(String imagePath) {
  return Image.network(
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
    frameBuilder: (BuildContext context, child, frame, wasSynchronouslyLoaded) {
      if (wasSynchronouslyLoaded) return child; // 同步完成，回傳child

      return AnimatedOpacity(
        opacity: frame == null ? 0 : 1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
        child: child,
      );
    },
    // loadingBuilder 的型別是 ImageLoadingBuilder
    // ImageChunkEvent 裡面有兩個屬性：cumulativeBytesLoaded 以及 expectedTotalBytes。
    // 一個是累積下載量，另一個則是預期下載量。
    // 最後，當下載完成時，ImageChunkEvent 為 null。
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;

      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
  );
}

CachedNetworkImage getCachedNetworkImage(String imagePath) {
  // final cacheManager = CacheManager();

  // cacheManager.cacheImage(imagePath);

  // final defaultCacheManager = DefaultCacheManager();

  // var file = defaultCacheManager.getImageFile(imagePath);

  // debugPrint(file);

  return CachedNetworkImage(
    imageUrl: imagePath,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
