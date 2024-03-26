import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  const DateWidget(
      {super.key,
      required this.title,
      required this.dateTime,
      this.titleColor = Colors.black});

  final String title;
  final DateTime dateTime;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(CupertinoIcons.calendar_circle_fill),
        const SizedBox(width: 3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: titleColor),
            ),
            Text(DateFormat("yyyy-MM-dd").format(dateTime))
          ],
        )
      ],
    );
  }
}
