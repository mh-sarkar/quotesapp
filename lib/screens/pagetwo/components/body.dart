import 'dart:convert';

import 'package:demoapp/screens/pagetwo/components/quotes-item.dart';
import 'package:demoapp/screens/pagetwo/components/tabbar-item.dart';
import 'package:flutter/material.dart';

class PageTwoBody extends StatefulWidget {
  @override
  _PageTwoBodyState createState() => _PageTwoBodyState();
}

class _PageTwoBodyState extends State<PageTwoBody> {
  String activeAuthor = "Thomas Edison";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          buildAuthorList(size, context),
          buildQuoteList(size, context),
        ],
      ),
    );
  }

  SingleChildScrollView buildQuoteList(Size size, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: size.height - 140,
        width: size.width,
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString("assets/database/quotes.json"),
            builder: (context, snapshot) {
              var data = jsonDecode(snapshot.data.toString());
              List<String> list = [];

              if (data != null)
                for (int i = 0; i < data.length; i++) {
                  print(activeAuthor);
                  if (data[i]["author"] == activeAuthor)
                    list.add(data[i]["text"]);
                }
              return ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return QuotesItem(
                    quote: list[index],
                  );
                },
              );
            }),
      ),
    );
  }

  SingleChildScrollView buildAuthorList(Size size, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 60,
        width: size.width,
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString("assets/database/quotes.json"),
          builder: (context, snapshot) {
            var data = jsonDecode(snapshot.data.toString());
            List<String> list = [];
            if (data != null)
              for (int i = 0; i < data.length; i++) {
                list.add(data[i]["author"]);
              }
            var newList = list.toSet().toList();

            return ListView.builder(
              itemCount: newList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return TabBarItem(
                  name: newList[index],
                  press: () {
                    setState(() {
                      activeAuthor = newList[index];
                      print(newList.length);
                    });
                  },
                  active: activeAuthor == newList[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
