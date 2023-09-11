import 'package:flutter/material.dart';
import '../app-router.delegate.dart';

import 'settings.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build HomePage');

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: ListView(children: [
        ListTile(
          title: const Text("自定義 push 方法"),
          subtitle: const Text('插入 widget 至 pages'),
          onTap: () {
            AppRouterDelegate.of(context).push(const SettingsPage());
            // Navigator.of(context).pop(); // 會進_onPopPage
          },
        ),
        ListTile(
          title: const Text("自定義 replace 方法"),
          subtitle: const Text('取代整個 pages'),
          onTap: () {
            AppRouterDelegate.of(context).pushNamed('/items');
          },
        ),
      ]),
    );
  }
}
