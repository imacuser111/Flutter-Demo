import 'dart:async';

import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with TickerProviderStateMixin {
  late StreamController _controller; // 控制器
  int num = 0;

  @override
  void initState() {
    super.initState();
    _controller = StreamController.broadcast(); // 初始化
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("局部刷新"),
      ),
      body: Center(
          child: StreamBuilder(
              initialData: num, // 初始化需要刷新的数据
              stream: _controller.stream, // 控制器对应的stream
              builder: (context, n) {
                return Text("data=${n.data}");// n.data 对应initialData的数据类型
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.sink.add(num++); // 更新数据
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 记得销毁
    _controller.close();
  }
}