//The screen where the user can search for a location among the locations list

//TO DO : Fix the search bar filter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/widgets/locationBox.dart';

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
  'Oslo',
  'Washington',
  'Mexico',
  'Roma',
  'Lisbonne',
  'Tokyo',
  'Seoul',
  'Pekin',
  'Montreal',
];

List<String> allcities = cities;

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffffff),
        elevation: 0,
        toolbarHeight: 150,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weather',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff000000)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: CupertinoSearchTextField(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  onChanged: searchCity,
                  backgroundColor: const Color(0xFF14213D),
                  itemColor: const Color(0xFFE5E5E5),
                  itemSize: 17,
                  placeholder: 'Enter your city name',
                  placeholderStyle: const TextStyle(
                    color: Color(0xFFE5E5E5),
                    fontSize: 15,
                  ),
                  prefixInsets: const EdgeInsets.only(left: 10),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFE5E5E5),
        child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (BuildContext context, int index) {
              return locationBox(cities[index]);
            }),
      ),
    );
  }

  void searchCity(String query) {
    final suggestions = allcities.where((city) {
      final cityName = city.toLowerCase();
      final input = query.toLowerCase();
      return cityName.contains(input);
    }).toList();

    setState(() {
      cities = suggestions;
    });
  }
}
