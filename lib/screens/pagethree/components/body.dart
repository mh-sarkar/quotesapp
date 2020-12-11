import 'dart:convert';

import 'package:demoapp/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PageThreeBody extends StatefulWidget {
  @override
  _PageThreeBodyState createState() => _PageThreeBodyState();
}

class _PageThreeBodyState extends State<PageThreeBody> {
  int touchedIndex;
  int len;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
            ),
            child: Text(
              "Pie Chart of Author",
              style: TextStyle(
                color: kTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text("Long tap in chart to see Author name and Persentage!", style: TextStyle(color: kTextColor, fontSize: 16),),
          FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString("assets/database/quotes.json"),
            builder: (context, snapshot) {
              List<Map<String, dynamic>> authorList =
                  parseJosn(snapshot.data.toString());
              return authorList.isNotEmpty
                  ? Column(
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (pieTouchResponse) {
                                setState(
                                  () {
                                    if (pieTouchResponse.touchInput
                                            is FlLongPressEnd ||
                                        pieTouchResponse.touchInput
                                            is FlPanEnd) {
                                      touchedIndex = -1;
                                    } else {
                                      touchedIndex =
                                          pieTouchResponse.touchedSectionIndex;
                                    }
                                  },
                                );
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(authorList),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(var authorList) {
    return List.generate(authorList.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      return PieChartSectionData(
        color: i % 2 == 0 ? Color(0xff0293ee) : Colors.green,
        value: len != null ? (authorList[i]['count'] / len) * 100 : 0,
        title: isTouched
            ? '${authorList[i]['author'] == null ? "Unkonwn" : authorList[i]['author']}\n${len != null ? ((authorList[i]['count'] / len) * 100).toStringAsFixed(3) : 0}'
            : "",
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: kTextColor),
      );
    });
  }

  List<Map<String, dynamic>> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    List list = [];
    len = parsed.length;
    for (int i = 0; i < parsed.length; i++) {
      list.add(parsed[i]["author"]);
    }
    var newList = list.toSet().toList();
    List<Map<String, dynamic>> newMap = [];
    for (int i = 0; i < newList.length; i++) {
      newMap.add({
        "author": newList[i],
        "count": parsed.where((e) => e['author'] == newList[i]).length
      });
    }
    return newMap;
  }
}
