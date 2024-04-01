import 'package:hive_flutter/hive_flutter.dart';
part 'habit_model.g.dart';

@HiveType(typeId: 6)
class HabitModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  List<String> maxCompleated;
  @HiveField(2)
  String? hkey;
  @HiveField(3)
  String maxSkipped;
  // @HiveField(4)
  // String? time;

  HabitModel({
    this.hkey,
    required this.title,
    required this.maxCompleated,
    required this.maxSkipped,
  });
}