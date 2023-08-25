import 'package:flutter/cupertino.dart';

abstract class StateLifecycleExtends<T> extends State {
  @override
  void initState() {
    debugPrint('${T.toString()} init state');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('${T.toString()} did change dependencies');
    super.didChangeDependencies();
  }

  // @override
  // void didUpdateWidget(T oldWidget) {
  //   debugPrint('${T.toString()} did update widget');
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void deactivate() {
    debugPrint('${T.toString()} deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('${T.toString()} dispose');
    super.dispose();
  }

  @override
  void reassemble() {
    debugPrint('${T.toString()} reassemble');
    super.reassemble();
  }
}