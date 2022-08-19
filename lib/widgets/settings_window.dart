// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:textly/widgets/icon_button.dart';

class SettingsWindow extends StatefulWidget {
  final void Function() closeWindowFunc;
  const SettingsWindow({Key? key, required this.closeWindowFunc}) : super(key: key);

  @override
  State<SettingsWindow> createState() => _SettingsWindowState();
}

class _SettingsWindowState extends State<SettingsWindow> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    double width = size.width * 0.9 - 50;
    double height = size.height * 0.9 - 50;

    return Container(
      width: size.width * 0.9,
      height: size.height * 0.9,
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.05, horizontal: size.width * 0.05),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Settings",
                    style: theme.textTheme.headline1,
                  ),
                  RetroIconButton(
                    tooltip: "Close",
                    icon: Icon(Icons.close_rounded, color: theme.accentColor),
                    onTap: this.widget.closeWindowFunc,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
