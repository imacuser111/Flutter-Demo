import 'package:flutter/material.dart';
import 'navigator_v1.dart';

class JumpProviderModel with ChangeNotifier {
  String result = "";

  void setResult(String result) {
    this.result = result;
    notifyListeners();
  }
}

abstract class Routes {
  static const first = '/';
  static const second = '/Second';
  static const three = '/Three';
}

Route<dynamic>? generateRoute(
    RouteSettings settings, List<String> visitedRoutes) {

  final routeName = settings.name ?? "";
  final uri = Uri.parse(routeName);

  print(visitedRoutes);
  print(routeName);

  // if (visitedRoutes.contains(routeName)) {
  //   return null;
  // }

  // visitedRoutes.add(routeName);

  switch (uri.path) {
    case Routes.second:
      final a = settings.arguments as String?;
      final queryParameters = uri.queryParameters;
      final str = a ?? queryParameters['str'] ?? 'Default String';

      return MaterialPageRoute(
        settings: RouteSettings(name: '${Routes.second}?str=$str'), // 網址顯示值
        builder: (context) => SecondScreen(str: str),
      );
  }
  return null;
}
