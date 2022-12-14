// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:textly/model/setting.dart';
import 'package:textly/pages/home_page.dart';
import 'package:textly/services/boxes.dart';
import 'package:textly/settings.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SettingAdapter());
  await Hive.openBox<Setting>("settings");

  Box<Setting> _settingsBox = Boxes.getSettingsBox();

  bool upToDate = true;
  int i = 0;

  for (Setting setting in defaultSettings) {
    Setting? currentSetting = _settingsBox.getAt(i);

    if (currentSetting == null || currentSetting.name != setting.name) {
      upToDate = false;
      break;
    }
    i += 1;
  }

  if (upToDate == false) {
    _settingsBox.clear();
    settings = defaultSettings;
    for (Setting setting in defaultSettings) {
      _settingsBox.add(setting);
    }
  } else {
    for (int i = 0; i <= defaultSettings.length - 1; i++) {
      settings.add(_settingsBox.getAt(i)!);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Textly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primaryColor: const Color(0xFFF5F5F5),
        accentColor: const Color(0xFFCCCCCC),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xFF111717),
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
          headline2: TextStyle(
            color: Color(0xFF111717),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            color: Color(0xFF3D3D3D),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: TextStyle(
            color: Color(0xFF111717),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A2223),
        primaryColor: const Color(0xFF171C1F),
        accentColor: const Color(0xFF000000),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
          headline2: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            color: Color(0xFFCCCCCC),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
