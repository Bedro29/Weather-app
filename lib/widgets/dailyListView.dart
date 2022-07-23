import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/CurrentWeatherPage.dart';
import 'package:weather/forecast.dart';

Widget dailyListView(double lon, lat) {
  return FutureBuilder(
      future: getDailyForecast(lon, lat),
      builder: ((context, snapshot) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

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
            List days = data['daily'];
            List<String> dayName = [
              'Sun',
              'Mon',
              'Tue',
              'Wed',
              'Thu',
              'Fri',
              'Sat',
            ];
            List<String> moments = ['morn', 'day', 'eve', 'night'];
            return ListView.builder(
                shrinkWrap: true,
                itemCount: days.length - 1,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: screenHeight * 0.1,
                        width: screenWidth,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(dayName[index]),
                                Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Text(
                                            '${days[index]['temp']['min'].round()} --- ${days[index]['temp']['max'].round()}'),
                                        SizedBox(
                                          width: screenWidth * 0.2,
                                        ),
                                        Text(days[index]['weather'][0]
                                                ['description']
                                            .toString()),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        }
      }));
}
