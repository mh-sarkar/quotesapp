import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:demoapp/Components/custom-drawer.dart';
import 'package:demoapp/screens/pageone/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'components/quoteoftheday.dart';

class PageOneScreen extends StatefulWidget {
  @override
  _PageOneScreenState createState() => _PageOneScreenState();
}

class _PageOneScreenState extends State<PageOneScreen> {
  String state = "one";
  int len;
  int index;
  String text, author;
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    _getIndexValue();
  }

  Future<void> _getIndexValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getInt('index') == null ? index = 0 : index = prefs.getInt('index');
    });
  }

  Future<void> _resetIndexValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('index', index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: CustomDrawer(
          state: state,
        ),
        appBar: buildAppBar(),
        body: Container(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/database/quotes.json"),
              builder: (context, snapshot) {
                // parseJosn(snapshot.data.toString());
                // text = quotes[index].text;
                // author = quotes[index].author;

                var data = jsonDecode(snapshot.data.toString());
                if (data != null) len = data.length;
                // text = data[index]['text'];
                // author = data[index]['author'];
                return data != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Text(
                            "Quote of The Day",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          QuoteOfTheDay(
                            size: size,
                            quote: data[index]['text'],
                            author: data[index]['author'],
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          PageOneButtons(
                            text: data[index]['text'],
                            author: data[index]['author'] != null
                                ? data[index]['author']
                                : "Unknown",
                          )
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        height: size.height,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Page One"),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              index = Random().nextInt(len);
              _resetIndexValue();
            });
          },
        )
      ],
    );
  }

  // List<QuoteModel> parseJosn(String response) {
  //   if (response == null) {
  //     return [];
  //   }
  //   final parsed =
  //       json.decode(response.toString()).cast<Map<String, dynamic>>();

  //   len = parsed.length;

  //   return parsed
  //       .map<QuoteModel>((json) => new QuoteModel.fromJson(json))
  //       .toList();
  // }
}
