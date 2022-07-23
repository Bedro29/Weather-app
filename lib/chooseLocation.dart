//The screen where the user can search for a location among the locations list

//TO DO : Fix the search bar filter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/widgets/locationBox.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

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
];

List<String> searchedcities = cities;

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        elevation: 0,
        toolbarHeight: 150,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Weather',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: OutlineSearchBar(
                  margin: EdgeInsets.only(top: 5),
                  borderColor: CupertinoColors.darkBackgroundGray,
                  borderWidth: 0,
                  clearButtonColor: CupertinoColors.inactiveGray,
                  hideSearchButton: true,
                  padding: EdgeInsets.only(left: 12),
                  cursorColor: Colors.white,
                  icon: Icon(
                    CupertinoIcons.search,
                    color: CupertinoColors.inactiveGray,
                  ),
                  clearButtonIconColor: CupertinoColors.darkBackgroundGray,
                  searchButtonIconColor: CupertinoColors.inactiveGray,
                  backgroundColor: Color.fromARGB(255, 89, 89, 94),
                  hintText: 'Enter the city name',
                  hintStyle: TextStyle(
                    color: CupertinoColors.inactiveGray,
                  ),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  searchButtonPosition: SearchButtonPosition.leading,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: CupertinoColors.darkBackgroundGray,
        child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (BuildContext context, int index) {
              return locationBox(cities[index]);
            }),
      ),
    );
  }
}
