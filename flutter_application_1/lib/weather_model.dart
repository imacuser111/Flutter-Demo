import 'package:flutter/material.dart';

enum Weather {
  sunny,
  rainy,
  typhoon,
  blizzard,
}

extension WeatherExtension on Weather {
  String get value {
    switch (this) {
      case Weather.sunny:
        return "sunny";
      case Weather.rainy:
        return "rainy";
      case Weather.typhoon:
        return "typhoon";
      case Weather.blizzard:
        return "blizzard";
    }
  }
}

typedef ValueCallback<T> = void Function(T vaule);

DropdownButton newDropdownButton(Weather weather, ValueCallback<Weather> closure) {
  return DropdownButton(
    hint: null,
    value: weather,
    items: const [
      DropdownMenuItem(value: Weather.sunny, child: Text("晴天")),
      DropdownMenuItem(value: Weather.rainy, child: Text("雨天")),
      DropdownMenuItem(value: Weather.typhoon, child: Text("颱風")),
      DropdownMenuItem(value: Weather.blizzard, child: Text("暴風雪")),
    ],
    onChanged: (v) {
      closure(v);
    },
  );
}
