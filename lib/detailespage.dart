import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weatherapp/dataset.dart';
import 'package:weatherapp/extraweather.dart';

class Detailespage extends StatelessWidget {
  final Weather tomorrowTemp;
  final List<Weather> seveDay;
  Detailespage(this.seveDay, this.tomorrowTemp);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [
          TomorrowWeather(tomorrowTemp),
          SevenDays(seveDay),
        ],
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  final tomorrowTemp;
  TomorrowWeather(this.tomorrowTemp);
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      color: Color(0xff00A1FF),
      glowColor: Color(0xff00A1FF),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    Text(
                      " 7 days",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(tomorrowTemp.image ?? ""))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tomorrow",
                      style: TextStyle(fontSize: 30, height: 0.1),
                    ),
                    Container(
                      height: 105,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlowText(
                            tomorrowTemp.max.toString(),
                            style: TextStyle(
                                fontSize: 80, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "/" + tomorrowTemp.min.toString() + "\u00B0",
                            style: TextStyle(
                                color: Colors.black54.withOpacity(0.3),
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      tomorrowTemp.name ?? "",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              right: 50,
              left: 50,
            ),
            child: Column(
              children: [
                Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                ExtraWeather(tomorrowTemp)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  final List<Weather> sevenDay;
  SevenDays(this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: sevenDay.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 20, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sevenDay[index].day ?? "",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 135,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage(
                            sevenDay[index].image ?? "",
                          ),
                          width: 40,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          sevenDay[index].name ?? "",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text("+", style: TextStyle(fontSize: 20)),
                      Text(
                        sevenDay[index].max.toString() + "\u00B0",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "+",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      Text(
                        sevenDay[index].min.toString() + "\u00B0",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
