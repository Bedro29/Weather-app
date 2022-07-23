import 'package:flutter/material.dart';
import 'package:weather/Weather.dart';

Widget WeatherBox(Weather weather) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${weather.city}, ${weather.country}",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "${(weather.temp).round()} ºC",
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "min :${(weather.low).round()} ºC  -  max :${(weather.high).round()} ºC",
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          weather.description,
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
