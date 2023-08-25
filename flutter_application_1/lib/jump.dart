import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lifecycle Example',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('FirstScreen: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('FirstScreen: didChangeDependencies');
  }

  String? result;
  void goToBPage(BuildContext context) async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SecondScreen(
          str: 'FirstPage傳過來的值',
        ),
      ),
    );

    // 沒有呼叫setState的話，並不會更新畫面
    setState(() { });
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
            Text('返回值： $result'),
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

  @override
  void deactivate() {
    debugPrint('FirstScreen: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('FirstScreen: dispose');
    super.dispose();
  }
}

class SecondScreen extends StatefulWidget {
  final String str;

  const SecondScreen({super.key, required this.str});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('SecondScreen: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('SecondScreen: didChangeDependencies');
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
            Text(widget.str),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'BBBB');
              },
              child: const Text('Back to First Screen'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    debugPrint('SecondScreen: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('SecondScreen: dispose');
    super.dispose();
  }
}
