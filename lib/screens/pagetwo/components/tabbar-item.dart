import 'package:flutter/material.dart';

import '../../../constants.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    Key key,
    @required this.name,
    @required this.press,
    this.active,
  }) : super(key: key);
  final String name;
  final Function press;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(kDefaultPadding + kDefaultPadding / 4),
          border: Border.all(color: active? kBackgroundColor.withOpacity(.8) : kPrimaryColor, width: 2),
          color: active ? kPrimaryColor : kPrimaryColor.withOpacity(.3),
        ),
        child: Text(
          name == null ? "Unknown" : name,
          style: TextStyle(
            color: active? kBackgroundColor : kPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
