import 'package:flutter/material.dart';

import '../../../constants.dart';

class QuoteOfTheDay extends StatelessWidget {
  const QuoteOfTheDay({
    Key key,
    @required this.quote,
    @required this.author,
    @required this.size,
  }) : super(key: key);
  final String quote, author;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size.width * .95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kPrimaryColor.withOpacity(.3),
        ),
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quote,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            Text(
              author !=null?
              "- $author" : "- Unknown",
              
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
