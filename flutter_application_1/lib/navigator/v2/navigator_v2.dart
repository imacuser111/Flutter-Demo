import 'package:flutter/material.dart';

import 'app-router.delegate.dart';

void main() => runApp(NavigatorV2App());

class NavigatorV2App extends StatelessWidget {

  final AppRouterDelegate _delegate = AppRouterDelegate();
  final AppRouterParser _parser = AppRouterParser();

  NavigatorV2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Navigator v2",
      routerDelegate: _delegate,
      routeInformationParser: _parser,
    );
  }
}