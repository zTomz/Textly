import 'package:hive/hive.dart';

part 'setting.g.dart';

@HiveType(typeId: 0)
class Setting extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool status;
  @HiveField(2)
  final DateTime lastChange;

  Setting({required this.name, required this.status, required this.lastChange});
}
