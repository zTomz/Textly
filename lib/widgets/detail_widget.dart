// ignore_for_file: unnecessary_this, deprecated_member_use

import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  final String count;
  final String title;

  const DetailWidget({Key? key, required this.count, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Container(
      width: size.width * 0.85,
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.accentColor,
            offset: const Offset(9, 9),
          ),
        ],
        border: Border.all(width: 9, color: theme.accentColor),
        color: theme.primaryColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.85 * 0.325,
            height: 70,
            child: Center(
              child: Text(this.count, style: theme.textTheme.bodyText2),
            ),
          ),
          Container(
            width: 10,
            height: 70,
            decoration: BoxDecoration(
              color: theme.accentColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                this.title,
                style: theme.textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
