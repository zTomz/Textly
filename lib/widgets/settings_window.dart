// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textly/model/setting.dart';
import 'package:textly/services/boxes.dart';
import 'package:textly/settings.dart';
import 'package:textly/widgets/icon_button.dart';
import 'package:textly/widgets/toogle_button.dart';

class SettingsWindow extends StatefulWidget {
  final void Function() closeWindowFunc;
  const SettingsWindow({Key? key, required this.closeWindowFunc})
      : super(key: key);

  @override
  State<SettingsWindow> createState() => _SettingsWindowState();
}

class _SettingsWindowState extends State<SettingsWindow> {
  Box<Setting> settingsBox = Boxes.getSettingsBox();

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
                  tooltip: "Close / Save",
                  icon: Icon(Icons.close_rounded, color: theme.accentColor),
                  onTap: this.widget.closeWindowFunc,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //! Performance
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Performance",
                      style: theme.textTheme.headline2,
                    ),
                  ),
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        settingsWidget(settings[0], 0, width),
                        settingsWidget(settings[1], 1, width),
                      ],
                    ),
                  ),
                  //! Letters
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Letters",
                      style: theme.textTheme.headline2,
                    ),
                  ),
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        settingsWidget(settings[2], 2, width),
                        settingsWidget(settings[3], 3, width),
                        settingsWidget(settings[4], 4, width),
                      ],
                    ),
                  ),
                  //! Words
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Words",
                      style: theme.textTheme.headline2,
                    ),
                  ),
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        settingsWidget(settings[5], 5, width),
                        settingsWidget(settings[6], 6, width),
                      ],
                    ),
                  ),
                  //! Words
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Sentence Starts",
                      style: theme.textTheme.headline2,
                    ),
                  ),
                  Container(
                    width: width,
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        settingsWidget(settings[7], 7, width),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsWidget(Setting setting, int index, double width) => Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            ToggleButton(
              status: setting.status,
              toggleFunc: () {
                setState(() {
                  settings[index] = Setting(
                    name: setting.name,
                    status: !setting.status,
                    lastChange: DateTime.now(),
                  );
                });
                settingsBox.putAt(index, setting);
              },
            ),
            const SizedBox(width: 20),
            SizedBox(width: width - 100, child: Text(setting.name)),
          ],
        ),
      );
}
