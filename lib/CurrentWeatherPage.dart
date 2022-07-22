import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/Weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather/chooseLocation.dart';

class CurrentWeatherPage extends StatefulWidget {
  late String cityName;
  CurrentWeatherPage({Key? key, required this.cityName}) : super(key: key);

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getCurrentWeather(widget.cityName),
            builder: (context, snapshot) {
              Weather? weather;
              if (snapshot != null) {
                weather = snapshot.data as Weather?;
                if (weather == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.bouncingBall(
                          color: Colors.black,
                          size: 75,
                        ),
                        const Text(
                          'Loading ... ',
                          style: TextStyle(fontSize: 50),
                        )
                      ],
                    ),
                  );
                } else {
                  return WeatherBox(weather);
                }
              } else {
                return errorIcon();
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => const ChooseLocation())));
          }),
          elevation: 0,
          child: const Icon(CupertinoIcons.location_fill),
        ));
  }
}

Future getCurrentWeather(String city) async {
  Weather weather;

  final response = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=f54be8866d65f0cc3b9473f77b310168"));

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
    return weather;
  } else {
    return errorIcon();
  }
}

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

Widget errorIcon() {
  return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
    Icon(
      Icons.error,
      size: 40,
    ),
    Text(
      'Oups, we got a problem',
      style: TextStyle(
        fontSize: 25,
      ),
    )
  ]));
}
