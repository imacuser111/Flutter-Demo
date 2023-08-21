import 'package:flutter/material.dart';
import 'package:flutter_application_1/weather.dart';
// import 'image.dart';

//  進入點
void main() {
  runApp(const WeatherPageInheritedWidget());
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
        body: const Body(),
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
        Container(
          color: Colors.red,
          child: const Row(
            children: [Padding(
              padding: EdgeInsets.only(right: 5),
              child: FlutterLogo(),
            ), Text("Qpp")],
          )
        ),
        Container(
          color: Colors.amber,
          child: const Text("123"),
        )
      ],
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int count = 0;

  @override
  void initState() {
    debugPrint('init state');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('did change dependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Body oldWidget) {
    count++;
    debugPrint('did update widget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    debugPrint('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('dispose');
    super.dispose();
  }

  @override
  void reassemble() {
    debugPrint('reassemble');
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // getCachedNetworkImage('https://picsum.photos/250?image=9'),
              // getNetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq6HRomJWKtFDvOelkYHwwjA-xe7Usq0JgWRkQDGWy&s'),
              // getAssetImage('assets/image/46b9568828d8ae7d5fd00c2c9305127f.png'),
              TextButton(
                child: const Text(
                  "data",
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () {
                  setState(() {
                    count ++;
                  });
                },
              ),
              Text(
                '$count',
                textDirection: TextDirection.ltr,
              )
            ],
          ),
        );
  }
}