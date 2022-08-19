import 'package:hive/hive.dart';
import 'package:textly/model/setting.dart';

class Boxes {
  static Box<Setting> getSettingsBox() => Hive.box<Setting>("settings");
}
