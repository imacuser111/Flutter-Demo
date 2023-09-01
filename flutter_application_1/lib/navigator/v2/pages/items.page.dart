import 'package:flutter/material.dart';
import '../app-router.delegate.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build ItemsPage');
    
    return Scaffold(
      appBar: AppBar(title: const Text("Items")),
      body: Center(
        child: TextButton(
          child: const Text("返回首頁"),
          onPressed: () {
            AppRouterDelegate.of(context).pushNamed('/settings');
            // Navigator.of(context).pop(); // 會進_onPopPage
          },
        ),
      ),
    );
  }
}

class PageRouteObserver extends RouteObserver<PageRoute<dynamic>> {}