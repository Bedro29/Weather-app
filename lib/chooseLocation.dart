import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'CurrentWeatherPage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

List<String> cities = [
  'London',
  'Paris',
  'Algiers',
  'Berlin',
  'Jakarta',
  'oslo',
];

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loactions'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (BuildContext context, int index) {
            return locationBox(cities[index]);
          }),
    );
  }
}

Future getCurrentData(String city) async {
  final response = await http.get(Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=f54be8866d65f0cc3b9473f77b310168"));

  Map<String, dynamic> data = {};

  data = jsonDecode(response.body);
  return data;
}

Widget locationBox(String city) {
  return FutureBuilder(
    future: getCurrentData(city),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot == null) {
        return errorIcon();
      } else {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.black,
              size: 30,
            ),
          );
          ;
        } else {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              child: Column(children: [
                Text(city),
                Text(snapshot.data['main']['temp'].toString()),
              ]),
            ),
          );
        }
      }
    },
  );
}
