// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class TwoInformationBox extends StatelessWidget {
  final String title;
  final List<String> info1;
  final List<String> info2;
  const TwoInformationBox({
    Key? key,
    required this.title,
    required this.info1,
    required this.info2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Container(
      height: 225,
      width: size.width * 0.85,
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
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 13, top: 10, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.title,
                  style: theme.textTheme.headline1!.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          underInformation(info1[1], info1[0], theme, size),
          underInformation(info2[1], info2[0], theme, size),
        ],
      ),
    );
  }

  Widget underInformation(
      String title, String value, ThemeData theme, Size size) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
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
            width: size.width * 0.85 * 0.35,
            height: 70,
            child: Center(
              child: Text(
                value,
                style: theme.textTheme.bodyText2,
              ),
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
                title,
                style: theme.textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
