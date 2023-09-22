import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
    height: 300,
    imagePath,
    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
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

Stream<FileResponse> getCachedNetworkImage(String imagePath) {
  // var fetchedFile = DefaultCacheManager()
  //     .getFileStream(imagePath, key: imagePath, withProgress: true);
  // print(fetchedFile);

  // DefaultCacheManager().getImageFile(imagePath);

  // return Image.file(fetchedFile, errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),);

  return CustomCacheManager()
      .cacheManager
      .getFileStream(imagePath, key: imagePath, withProgress: true);

  // return CachedNetworkImage(
  //   fit: BoxFit.contain,
  //   imageUrl: imagePath,
  //   // placeholder: (context, url) => const CircularProgressIndicator(),
  //   // errorWidget: (context, url, error) => const Icon(Icons.error),
  // );

//   return CachedNetworkImage(
//   imageUrl: "http://via.placeholder.com/200x150",
//   imageBuilder: (context, imageProvider) {
//     return Ink.image(
//       image: imageProvider,
//       height: 300,
//     );
//   },
//  placeholder: (context, url) => const CircularProgressIndicator(),
// )
}

// for Image.network 配置
void configureImageCache() {
  // 設定磁盤緩存大小為 20MB
  PaintingBinding.instance.imageCache.maximumSizeBytes =
      20 * 1024 * 1024; // 20MB

  // 設定內存緩存大小為 5MB
  PaintingBinding.instance.imageCache.maximumSize = 100; // 5MB
}

// for CachedNetworkImage 配置
class CustomCacheManager {
  CustomCacheManager._internal();

  factory CustomCacheManager() => _instance;

  static final CustomCacheManager _instance = CustomCacheManager._internal();

  final CacheManager cacheManager = CacheManager(
    Config(
      'images_Key',
      maxNrOfCacheObjects: 20, // 允許快取的大小，若超過就從最久未被使用的cache開始移除
      stalePeriod: const Duration(days: 3), // cache檔案在超過3天都沒有開啟過就移除
    ),
  );
}
