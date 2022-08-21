// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:textly/model/setting.dart';
import 'package:textly/services/boxes.dart';
import 'package:textly/settings.dart';
import 'package:textly/widgets/icon_button.dart';
import 'package:textly/widgets/toogle_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsWindow extends StatefulWidget {
  final void Function() closeWindowFunc;
  const SettingsWindow({Key? key, required this.closeWindowFunc})
      : super(key: key);

  @override
  State<SettingsWindow> createState() => _SettingsWindowState();
}

class _SettingsWindowState extends State<SettingsWindow> {
  Box<Setting> settingsBox = Boxes.getSettingsBox();

  bool fullScreen = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    double width = size.width * 0.9 - 50;
    double height = size.height * 0.9 - 50;

    return Container(
      width: fullScreen ? size.width : size.width * 0.9,
      height: fullScreen ? size.height : size.height * 0.9,
      margin: EdgeInsets.symmetric(
        vertical: fullScreen ? 0 : size.height * 0.05,
        horizontal: fullScreen ? 0 : size.width * 0.05,
      ),
      decoration: fullScreen
          ? BoxDecoration(
              color: theme.primaryColor,
            )
          : BoxDecoration(
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
          if (fullScreen) const SizedBox(height: 30),
          Container(
            width: width,
            margin: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Text(
                  "Settings",
                  style: theme.textTheme.headline1,
                ),
                const Spacer(),
                RetroIconButton(
                  tooltip: "Full Screen",
                  icon: Icon(
                    !fullScreen
                        ? Icons.fullscreen_rounded
                        : Icons.fullscreen_exit_outlined,
                    color: theme.accentColor,
                  ),
                  onTap: () {
                    setState(
                      () {
                        fullScreen = !fullScreen;
                      },
                    );
                  },
                ),
                const SizedBox(width: 12.5),
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
                  GestureDetector(
                    onTap: () async {
                      if (!await launchUrl(
                          Uri.parse("https://ko-fi.com/ztomz"))) {
                        throw 'Could not launch https://ko-fi.com/ztomz';
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: width - 50,
                      child: Image.asset("assets/img/kofi_button_red.png"),
                    ),
                  ),
                  const SizedBox(height: 7),
                  GestureDetector(
                    onTap: () async {
                      if (!await launchUrl(
                          Uri.parse("https://github.com/zTomz/Textly"))) {
                        throw 'Could not launch https://github.com/zTomz/Textly';
                      }
                    },
                    child: Container(
                      width: width - 50,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 4,
                          color: theme.accentColor,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/img/github.png"),
                            const SizedBox(width: 7),
                            const Text("GitHub"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                settingsBox.putAt(index, settings[index]);
              },
            ),
            const SizedBox(width: 20),
            SizedBox(width: width - 100, child: Text(setting.name)),
          ],
        ),
      );
}
