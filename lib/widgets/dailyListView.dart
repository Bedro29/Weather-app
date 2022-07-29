import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/forecast.dart';
import 'package:weather/material/getAsset.dart';

Widget dailyListView(double lon, lat) {
  return FutureBuilder(
      future: getDailyForecast(lon, lat),
      builder: ((context, snapshot) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        if (snapshot.data == null) {
          // return errorIcon();
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
            'tod.',
            'Sun.',
            'Mon.',
            'Tue.',
            'Wed.',
            'Thu.',
            'Fri.',
            'Sat.',
          ];

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: days.length,
                      itemBuilder: (context, index) {
                        String asset = getAsset(days[index]['weather'][0]
                                ['description']
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                          child: Column(
                            children: [
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dayName[index],
                                    style: const TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                  FittedBox(
                                    child: SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset('assets/$asset')),
                                  ),
                                  Text(
                                    '${days[index]['temp']['min'].round()}º --- ${days[index]['temp']['max'].round()}º ',
                                    style: const TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        }
      }));
}
