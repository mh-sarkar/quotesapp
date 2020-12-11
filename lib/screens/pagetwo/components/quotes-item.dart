import 'package:flutter/material.dart';

import '../../../constants.dart';

class QuotesItem extends StatelessWidget {
  const QuotesItem({
    Key key,
    @required this.quote,
  }) : super(key: key);
  final String quote;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding / 2),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(kDefaultPadding),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(.2),
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        quote,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

