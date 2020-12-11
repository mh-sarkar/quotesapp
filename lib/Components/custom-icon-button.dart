import 'package:flutter/material.dart';

import '../constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key key,
      @required this.name,
      @required this.icon,
      @required this.press,
      @required this.color,
      @required this.backgroundColor})
      : super(key: key);
  final String name;
  final Icon icon;
  final Function press;
  final Color color, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      color: backgroundColor,
      onPressed: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: kDefaultPadding / 4,
            ),
            Text(
              name,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ],
        ),
      ),
    );
  }
}
