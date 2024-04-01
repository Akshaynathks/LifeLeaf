import 'package:hive_flutter/hive_flutter.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: 5)
class ReminderModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String? rkey;
  @HiveField(3)
  String? date;
  // @HiveField(4)
  // String? time;

  ReminderModel({
    this.rkey,
    required this.title,
    required this.description,
    required this.date,
  });
}
