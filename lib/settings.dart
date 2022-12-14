import 'package:textly/model/setting.dart';

List<Setting> settings = [];

//! Settings
List<Setting> defaultSettings = [
  //? Performance
  Setting(
    name: "Show Percentage",
    status: true,
    lastChange: DateTime.now(),
  ),
  Setting(
    name: "Show Diagrams",
    status: true,
    lastChange: DateTime.now(),
  ),
  //? Sentence lenght
  Setting(
    name: "Calculate sentence lenght",
    status: true,
    lastChange: DateTime.now(),
  ),
  //? Letters
  Setting(
    name: "Count Spaces",
    status: false,
    lastChange: DateTime.now(),
  ),
  Setting(
    name: "Different Between Write Case | Letters",
    status: false,
    lastChange: DateTime.now(),
  ),
  Setting(
    name: "Sort Letters",
    status: true,
    lastChange: DateTime.now(),
  ),
  //? Words
  Setting(
    name: "Different Between Write Case | Words",
    status: true,
    lastChange: DateTime.now(),
  ),
  Setting(
    name: "Sort Words",
    status: true,
    lastChange: DateTime.now(),
  ),
  //? Sentence Sarts
  Setting(
    name: "Sort Sentence Start Words",
    status: true,
    lastChange: DateTime.now(),
  ),
];
