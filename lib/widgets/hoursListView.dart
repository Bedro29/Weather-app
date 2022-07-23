import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/CurrentWeatherPage.dart';
import 'package:weather/forecast.dart';

Widget hourlyListView(double lon, lat) {
  return FutureBuilder(
      future: getHourlyForecast(lon, lat),
      builder: (context, snapshot) {
        double screenWidth = MediaQuery.of(context).size.width;

        if (snapshot.data == null) {
          return errorIcon();
        } else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.black,
                size: 30,
              ),
            );
          } else {
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
            List hours = data["hourly"];
            return SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: hours.length,
                    itemBuilder: (context, int index) {
                      return SizedBox(
                        width: screenWidth * 0.3,
                        height: 100,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          color: const Color.fromARGB(172, 124, 241, 237),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${hours[index]['temp'].round()}'),
                                Text(hours[index]['weather'][0]['description']
                                    .toString()),
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
          }
        }
      });
}
