import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider

// // Model
// class Person {
//   String name = "ChangeNotifierProvider";
// }

// // View
// class ProviderDemo extends StatelessWidget {
//   const ProviderDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Consumer<Person>(builder: (_, person, child) {
//           return Text(person.name);
//         }),
//       ),
//     );
//   }
// }

/// ChangeNotifierProvider

// Model
class Person with ChangeNotifier {
  String name = "ChangeNotifierProvider";

  /// 提供一个改变name的方法
  void changName({required String newName}) {
    name = newName;
    notifyListeners();
  }
}

// View
class ChangeNotifierProviderDemo extends StatelessWidget {
  const ChangeNotifierProviderDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChangeNotifierProvider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// 拿到person对象，读取数据
            Consumer<Person>(
              builder: (ctx, person, child) => Text(person.name),
            ),

            /// 拿到person对象，调用方法
            Consumer<Person>(
              builder: (ctx, person, child) {
                return ElevatedButton(
                  /// 点击按钮，调用方法更新
                  onPressed: () =>
                      person.changName(newName: "ChangeNotifierProvider更新了"),
                  child: const Text("點擊更新"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// FutureProvider

// // Model
// class Person {
//   String name;
//   Person({required this.name});
// }

// // ViewModel
// class FutureProviderDemo extends StatelessWidget {
//   const FutureProviderDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("FutureProvider"),
//       ),
//       body: Center(
//         child: Consumer<Person>(
//           builder: (ctx, person, child) => Text(person.name),
//         ),
//       ),
//     );
//   }
// }

// /// StreamProvider

// // Model
// class Person {
//   String name;
//   Person({required this.name});
// }

// // View
// class StreamProviderDemo extends StatelessWidget {
//   const StreamProviderDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("StreamProvider"),
//       ),
//       body: Center(
//         child: Consumer<Person>(
//           builder: (ctx, person, child) => Text(person.name),
//         ),
//       ),
//     );
//   }
// }
