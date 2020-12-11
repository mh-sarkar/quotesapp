import 'package:demoapp/Components/custom-icon-button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../../../constants.dart';

class PageOneButtons extends StatefulWidget {
  const PageOneButtons({
    Key key,
    this.text,
    this.author,
  }) : super(key: key);
  final String text, author;
  @override
  _PageOneButtonsState createState() => _PageOneButtonsState();
}

class _PageOneButtonsState extends State<PageOneButtons> {
  DateTime selectedDate = DateTime.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomIconButton(
          name: "Time Picker",
          icon: Icon(
            Icons.date_range,
            color: kBackgroundColor,
          ),
          press: () async {
            final selectedDate = await _selectDateTime(context);
            if (selectedDate == null) return;

            print(selectedDate);

            final selectedTime = await _selectTime(context);
            if (selectedTime == null) return;
            print(selectedTime);

            setState(() {
              this.selectedDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              );
            });
          },
          color: kBackgroundColor,
          backgroundColor: kPrimaryColor,
        ),
        CustomIconButton(
          name: "Share Quote",
          icon: Icon(
            Icons.share,
            color: kPrimaryColor,
          ),
          press: () {
            final String text = "${widget.text} - ${widget.author} $selectedDate";
            final String des = "You should try this app for earn money";
            final RenderBox box = context.findRenderObject();
            Share.share(text,
                subject: des,
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          },
          color: kPrimaryColor,
          backgroundColor: kBackgroundColor,
        ),
      ],
    );
  }


  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
}
