import 'package:flutter/material.dart';
import 'package:flutter_application_1/weather_model.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class WeatherWidget extends InheritedWidget {
  //官方建議要用final, 這樣你就不能隨便去改它
  final Weather todayWeather;

  //因為是要放在上層, 所以建構子一定要有child, 跟你要共享的資料
  const WeatherWidget(this.todayWeather, Widget cho, {super.key})
      : super(child: cho);

  //of方法是一個慣例, 代表這個widget是開放給大家取用, 官方建議這麼寫
  static WeatherWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WeatherWidget>();
    //如果用getElementForInheritedWidgetOfExactType, 繼承的widget就不會call didChangeDependencies
    //return context.getElementForInheritedWidgetOfExactType<WeatherWidget>().widget;
  }

  //此widget更新後是否通知其他widget
  @override
  bool updateShouldNotify(WeatherWidget oldWidget) {
    return oldWidget.todayWeather != todayWeather;
  }
}

/// InheritedWidget

class WeatherPageInheritedWidget extends StatefulWidget {
  const WeatherPageInheritedWidget({super.key});

  @override
  StateLifecycleExtends<WeatherPageInheritedWidget> createState() =>
      _WeatherPageInheritedWidget();
}

class _WeatherPageInheritedWidget
    extends StateLifecycleExtends<WeatherPageInheritedWidget> {
  Weather currentWeather = Weather.sunny;

  // 使用 ValueNotifier 來管理狀態
  ValueNotifier<Weather> currentWeatherNotifier =
      ValueNotifier<Weather>(Weather.sunny);

  @override
  Widget build(BuildContext context) {
    debugPrint('build: WeatherPageInheritedWidget');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('weather'),
          actions: <Widget>[
            newDropdownButton(
              currentWeather,
              (vaule) {
                setState(() {
                  currentWeather = vaule;
                });
                // currentWeatherNotifier.value = vaule;
              },
            )
          ],
        ),
        backgroundColor: Colors.red,
        body: WeatherWidget(
          currentWeather,
          const SkyWidget(),
        ),
        // // 使用 ValueListenableBuilder 監聽狀態變化，只重新構建 WeatherWidget
        // body: ValueListenableBuilder<Weather>(
        //   valueListenable: currentWeatherNotifier,
        //   builder: (context, currentWeather, child) {
        //     return WeatherWidget(currentWeather, const SkyWidget());
        //   },
        // ),
      ),
    );
  }
}

class SkyWidget extends StatelessWidget {
  const SkyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: SkyWidget');

    Widget widgetIcon(IconData ico) {
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
}

// class _SkyWidgetState extends StateLifecycleExtends<SkyWidget> {

// }

/// ChangeNotifierProvider

class WeatherProviderModel with ChangeNotifier {
  Weather weather = Weather.sunny;

  void selectedWeather(Weather weather) {
    this.weather = weather;
    notifyListeners();
  }
}

class WeatherPageProviderWidget extends StatelessWidget {
  const WeatherPageProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('123');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('weather'),
          actions: <Widget>[
            Consumer<WeatherProviderModel>(builder: (context, value, child) {
              return newDropdownButton(value.weather, (weather) {
                value.selectedWeather(weather);
              });
            })
          ],
        ),
        backgroundColor: Colors.red,
        body: const SkyProviderWidget(),
      ),
    );
  }
}

class SkyProviderWidget extends StatelessWidget {
  const SkyProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('sky 321');

    Widget widgetIcon(IconData ico) {
      return Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: Icon(ico, color: Colors.white, size: 100),
      );
    }

    return Consumer<WeatherProviderModel>(
      builder: (context, value, child) {
        switch (value.weather) {
          case Weather.sunny:
            return widgetIcon(IcoFontIcons.sunny);
          case Weather.rainy:
            return widgetIcon(IcoFontIcons.rainy);
          case Weather.typhoon:
            return widgetIcon(IcoFontIcons.wind);
          case Weather.blizzard:
            return widgetIcon(IcoFontIcons.snow);
          // default:
          //   return Container(color: Colors.red, child: child);
        }
      },
      child: const Text('Error'),
    );
  }
}
