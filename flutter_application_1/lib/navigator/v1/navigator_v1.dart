import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigator_v1_model.dart';

class MyApp extends StatelessWidget {
  final List<String> visitedRoutes = []; // 紀錄已經訪問過的路由

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('MyApp build');

    final GlobalKey<NavigatorState> mainNavigatorKey =
        GlobalKey<NavigatorState>();
    final List<String> visitedRoutes = [];

    return ChangeNotifierProvider<JumpProviderModel>(
      create: (context) => JumpProviderModel(),
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        onGenerateRoute: (settings) => generateRoute(settings, visitedRoutes),
        routes: {
          Routes.first: (context) => FirstScreen(navigatorKey: mainNavigatorKey,),
          Routes.second: (context) => const SecondScreen(str: '1111111',),
          Routes.three: (context) => const ThreeScreen(),
        },
        title: 'navigator_v1 Example',
        initialRoute: Routes.first,
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const FirstScreen({super.key, this.navigatorKey});

  void goToBPage(BuildContext context) {
    // 無需context
    navigatorKey?.currentState?.pushNamed(Routes.second, arguments: "123");

    // 需要context
    // navigatorKey?.currentState?.push(
    //   MaterialPageRoute(
    //     settings: const RouteSettings(name: '${Routes.second}?str=FirstPage傳過來的值'),
    //     builder: (context) => const SecondScreen(
    //       str: 'FirstPage傳過來的值',
    //     ),
    //   ),
    // );

    // Navigator.pushNamed(context, Routes.second, arguments: "222");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('FirstScreen: build');

    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Selector<JumpProviderModel, String>(
              selector: (p0, p1) => p1.result,
              builder: (context, result, child) {
                return Text('返回值： $result');
              },
              // Consumer<JumpProviderModel>(
              //   builder: (context, model, child) {
              //     return Text('返回值： ${model.result}');
              //   },
            ),
            ElevatedButton(
              onPressed: () {
                goToBPage(context);
              },
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String str;

  const SecondScreen({super.key, required this.str});

  void goToCPage(BuildContext context) {
    Navigator.pushNamed(context, Routes.three);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('SecondScreen: build');

    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(str),
            ElevatedButton(
              onPressed: () {
                Provider.of<JumpProviderModel>(context, listen: false)
                    .setResult('123');

                goToCPage(context);
              },
              child: const Text('Go to Three Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThreeScreen extends StatelessWidget {
  const ThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('ThreeScreen: build');
    return Scaffold(
      appBar: AppBar(title: const Text('Three Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Three'),
            ElevatedButton(
              onPressed: () {
                Provider.of<JumpProviderModel>(context, listen: false)
                    .setResult('123');

                // Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName(Routes.first));
              },
              child: const Text('Back to First Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
