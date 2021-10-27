import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weatherapp/dataset.dart';
import 'package:weatherapp/detailespage.dart';
import 'package:weatherapp/extraweather.dart';

Weather currentTemp = currentTemp;
Weather tomorrowTemp = tomorrowTemp;
List<Weather> todayWeather = todayWeather;
List<Weather> seveDay = seveDay;
String lat = "33.44";
String lon = "-94.04";
String city = "Chicago";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    fetchData(lat, lon, city).then((value) {
      currentTemp = value[0];
      todayWeather = value[1];
      tomorrowTemp = value[2];
      seveDay = value[3];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [CurrentWeather(), TodayWeather()],
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      height: MediaQuery.of(context).size.height - 210,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 50, left: 30, right: 30),
      glowColor: Color(0xff00A1FF).withOpacity(0.5),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(60),
      ),
      color: Color(0xff00A1FF),
      spreadRadius: 5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                CupertinoIcons.square_grid_2x2,
                color: Colors.white,
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.map_fill,
                    color: Colors.white,
                  ),
                  Text(" "),
                  Text(
                    currentTemp.location ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
              Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              "Updating",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Container(
            height: 320,
            child: Stack(
              children: [
                Image(
                  image: AssetImage(currentTemp.image ?? ""),
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 7,
                  child: Center(
                    child: Column(
                      children: [
                        GlowText(
                          currentTemp.current.toString(),
                          style: TextStyle(
                              fontSize: 70, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          currentTemp.name ?? "",
                          style: TextStyle(fontSize: 19),
                        ),
                        Text(
                          currentTemp.day ?? "",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          ExtraWeather(currentTemp)
        ],
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  const TodayWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 7),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Detailespage(seveDay, tomorrowTemp);
                  }));
                },
                child: Row(
                  children: [
                    Text(
                      "7 days",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherWidget(todayWeather[0]),
                WeatherWidget(todayWeather[1]),
                WeatherWidget(todayWeather[2]),
                WeatherWidget(todayWeather[3]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget(this.weather);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.white),
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Text(
            weather.current.toString() + "\u00B0",
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 3,
          ),
          Image(
            image: AssetImage(weather.image ?? ""),
            width: 45,
            height: 45,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            weather.time ?? "",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
