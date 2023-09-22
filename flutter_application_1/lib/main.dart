import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'image.dart';

//  進入點
void main() {
  // runApp(NavigatorV2App());

  // runApp(MyApp());
  runApp(const DemoApp());
  // runApp(const WeatherPageInheritedWidget());

  // runApp(ChangeNotifierProvider<WeatherProviderModel>(
  //   create: (context) => WeatherProviderModel(),
  //   child: const WeatherPageProviderWidget(),
  // ));

  // runApp(FutureProvider<Person>(
  //   initialData: Person(name: "初始值"),
  //   create: (ctx) {
  //     /// 延遲2s後更新
  //     return Future.delayed(
  //         const Duration(seconds: 2), () => Person(name: "更新FutureProvider"));
  //   },
  //   child: const MaterialApp(
  //     home: FutureProviderDemo(),
  //   ),
  // ));

  // runApp(StreamProvider<Person>(
  //   initialData: Person(name: "初始值"),
  //   create: (ctx) {
  //     /// 傳入一個Stream，每間隔1s數據更新一次
  //     return Stream<Person>.periodic(const Duration(seconds: 1), (value) {
  //       return Person(name: "StreamProvider ---  $value");
  //     });
  //   },
  //   child: const MaterialApp(
  //     home: StreamProviderDemo(),
  //   ),
  // ));
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(),
          toolbarHeight: 100,
          backgroundColor: Colors.blue.withAlpha(0),
        ),
        body: const Home(),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    //↓↓↓更改此處程式碼↓↓↓
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Container(
        //     color: Colors.red,
        //     child: const Row(
        //       children: [
        //         Padding(
        //           padding: EdgeInsets.only(right: 5),
        //           child: FlutterLogo(),
        //         ),
        //         Text("Qpp"),
        //       ],
        //     )),
        Container(
          color: Colors.amber,
          child: const Text("123"),
        )
      ],
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String imageUrl =
      'https://storage.googleapis.com/qpp_blockchain_test/Profile/A277C9AE4C10A9D5F23BB9F049F5D5344A671404D16EB40CF79A0ECEFEE811A9_Image1.png?v=${DateTime.now().millisecondsSinceEpoch}';
  // 'https://static7.depositphotos.com/1044234/755/i/600/depositphotos_7553041-stock-photo-road-tripping.jpg';
  final String imageUrl2 =
      'https://picsum.photos/250?image=9'; // https://fastly.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI

  final customCacheManager = CustomCacheManager();

  @override
  Widget build(BuildContext context) {
    print(12312321);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CachedNetworkImage(
            key: UniqueKey(),
            cacheKey: 'first_image',
            cacheManager: customCacheManager.cacheManager,
            imageUrl: imageUrl,
            width: MediaQuery.of(context).size.width,
            height: 250,
            progressIndicatorBuilder: (context, url, progress) {
              return ColoredBox(
                color: Colors.black12,
                child: Center(
                    child: CircularProgressIndicator(
                  value: progress.progress,
                )),
              );
            },
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const ColoredBox(
              color: Colors.black12,
              child: Icon(
                Icons.error,
                size: 50,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            key: UniqueKey(),
            radius: 100,
            backgroundColor: Colors.black12,
            backgroundImage: 
            CachedNetworkImageProvider(
              imageUrl2,
              cacheManager: customCacheManager.cacheManager,
              cacheKey: 'second_image',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: clearCache, child: const Text('Clear cache')),
          ElevatedButton(
              onPressed: () => clearCache(index: 0),
              child: const Text('Clear First Image')),
          ElevatedButton(
              onPressed: () => clearCache(index: 1),
              child: const Text('Clear Second Image')),
        ],
      ),
    );
  }

  void clearCache({int? index}) {
    imageCache.clear();
    imageCache.clearLiveImages();

    if (index != null) {
      customCacheManager.cacheManager
          .removeFile(index == 0 ? 'first_image' : 'second_image');
    } else {
      customCacheManager.cacheManager.emptyCache();
    }

    setState(() {});
  }
}
