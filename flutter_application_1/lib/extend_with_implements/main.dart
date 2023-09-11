import 'package:flutter/material.dart';
import 'package:flutter_application_1/extend_with_implements/model.dart';

import '../main.dart';

//  進入點
void main() {
  runApp(const DemoApp());
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

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Mixin mixin = Mixin(123);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              child: const Text(
                "button",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () => debugPrint(mixin.getName())),
        ],
      ),
    );
  }
}
