import 'package:flutter/material.dart';

import '../constants.dart';

class DrawerListButton extends StatelessWidget {
  const DrawerListButton({
    Key key,
    @required this.name,
    @required this.press,
  }) : super(key: key);
  final String name;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: press,
    );
  }
}