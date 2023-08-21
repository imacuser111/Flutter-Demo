import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

enum Weather {
  sunny,
  rainy,
  typhoon,
  blizzard,
}

class WeatherWidget extends InheritedWidget {
  //官方建議要用final, 這樣你就不能隨便去改它
  final Weather todayWeather;

  //因為是要放在上層, 所以建構子一定要有child, 跟你要共享的資料
  const WeatherWidget(this.todayWeather, Widget cho, {super.key})
      : super(child: cho);

  //of方法是一個慣例, 代表這個widget是開放給大家取用, 官方建議這麼寫
  static WeatherWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WeatherWidget>();
    //如果用getElementXXX太長的背不起來, 繼承的widget就不會call didChangeDependencies
    //return context.getElementForInheritedWidgetOfExactType<GodWidget>().widget;
  }

  //此widget更新後是否通知其他widget
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class WeatherPageInheritedWidget extends StatefulWidget {
  const WeatherPageInheritedWidget({super.key});
  @override
  State<WeatherPageInheritedWidget> createState() => _WeatherPageInheritedWidget();
}

class _WeatherPageInheritedWidget extends State<WeatherPageInheritedWidget> {
  String currentMood = "123";
  Weather currentWeather = Weather.sunny;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("第十八堂課",),
          actions: <Widget>[
            DropdownButton(
                hint: const Text("心情？"),
                value: null,
                items: const [
                  DropdownMenuItem(value: Weather.sunny, child: Text("大晴天")),
                  DropdownMenuItem(value: Weather.rainy, child: Text("下雨天")),
                  DropdownMenuItem(value: Weather.typhoon, child: Text("做颱風")),
                  DropdownMenuItem(value: Weather.blizzard, child: Text("暴風雪")),
                ],
                onChanged: (v) {
                  setState(() {
                    currentWeather = v ?? Weather.sunny;
                  });
                })
          ],
        ),
        backgroundColor: Colors.red,
        body: WeatherWidget(currentWeather, const SkyWidget()))
    );
  }
}

class SkyWidget extends StatefulWidget {
  const SkyWidget({super.key});

  @override
  State<SkyWidget> createState() => _SkyWidgetState();
}

class _SkyWidgetState extends State<SkyWidget> {
  @override
  Widget build(BuildContext context) {

    Widget widgetIcon(IconData ico){
      return Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: Icon(ico, color: Colors.white, size: 100),
      );
    }

    switch (WeatherWidget.of(context)?.todayWeather) {
      case Weather.sunny:
        return widgetIcon(IcoFontIcons.sunny);
      case Weather.rainy:
        return widgetIcon(IcoFontIcons.rainy);
      case Weather.typhoon:
        return widgetIcon(IcoFontIcons.wind);
      case Weather.blizzard:
        return widgetIcon(IcoFontIcons.snow);
      default:
        return Container(child: null, color: Colors.red);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("weather didChangeDependencies");
  }
}
