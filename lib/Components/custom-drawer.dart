import 'package:demoapp/Components/drawer-list-button.dart';
import 'package:demoapp/screens/pageone/pageone.dart';
import 'package:demoapp/screens/pagethree/pagethree.dart';
import 'package:demoapp/screens/pagetwo/pagetwo.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
    this.state,
  }) : super(key: key);
  final String state;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'DEMO APP',
              style: TextStyle(
                color: kBackgroundColor,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          DrawerListButton(
            name: "Page One",
            press: () {
              state == "one"
                  ? Navigator.pop(context)
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageOneScreen(),
                      ),
                    );
            },
          ),
          DrawerListButton(
            name: "Page Two",
            press: () {
              state == "two"
                  ? Navigator.pop(context)
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageTwoScreen(),
                      ),
                    );
            },
          ),
          DrawerListButton(
            name: "Page Three",
            press: () {
              state == "three"
                  ? Navigator.pop(context)
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageThreeScreen(),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
