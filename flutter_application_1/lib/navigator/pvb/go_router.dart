// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigator/v2/pages/settings.page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


void main() { 
  //建立URL策略，用以移除頁出現http://localhost:5654/#/的#字hash
  usePathUrlStrategy();
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'details',
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'new',
              builder: (BuildContext context, GoRouterState state) {
                return const NewScreen();
              },
            ),
          ],
        ),
        GoRoute(
          name: 'settings',
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            // print('${state.pathParameters} 12313');
            return const SettingsPage();
          },
        )
      ],
    ),
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('myApp rebuild');
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('HomeScreen 123');
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/details'),
          child: const Text('Go to the Details screen'),
        ),
      ),
    );
  }
}

/// The details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('DetailsScreen 123');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        automaticallyImplyLeading: false, // 隱藏返回鈕
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/details/new'),
          child: const Text('Go to the New screen'),
        ),
      ),
    );
  }
}

/// The NewScreen screen
class NewScreen extends StatelessWidget {
  /// Constructs a [NewScreen]
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('NewScreen 123');

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Screen'),
        automaticallyImplyLeading: false, // 隱藏返回鈕
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}
