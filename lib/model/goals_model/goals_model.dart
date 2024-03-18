import 'package:hive_flutter/hive_flutter.dart';
part 'goals_model.g.dart';

@HiveType(typeId: 2)
class GoalsModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  String? key;
  @HiveField(3)
  String? targetDate;
  @HiveField(4)
  String? step;

  GoalsModel({
    this.key,
    required this.description,
    required this.targetDate,
    required this.title,
    required this.step
  });
}
