import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather/Weather.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weather/chooseLocation.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getCurrentWeather('tlemcen'),
            builder: (context, snapshot) {
              Weather? _weather;
              if (snapshot != null) {
                _weather = snapshot.data as Weather?;
                if (_weather == null) {
                  return errorIcon();
                  //return errorIcon();
                } else {
                  return WeatherBox(_weather);
                }
              } else {
                return Loading();
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => ChooseLocation())));
          }),
          child: Icon(CupertinoIcons.location_fill),
          elevation: 0,
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

Widget WeatherBox(Weather _weather) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${_weather.city}, ${_weather.country}",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "${(_weather.temp).round()} ºC",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "min :${(_weather.low).round()} ºC  -  max :${(_weather.high).round()} ºC",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${_weather.description}",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

Widget errorIcon() {
  return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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

Widget Loading() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Text('Loading ...'),
      ],
    ),
  );
}
