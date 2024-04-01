import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
part 'goals_main_model.g.dart';

@HiveType(typeId: 1)
class GoalsMainModel {
  @HiveField(0)
  String? goalTitle;
  @HiveField(1)
  final List<GoalsModel> goalList;
  @HiveField(2)
  String? key;
  @HiveField(3)
  int? isMarked;

  GoalsMainModel({
    this.key,
    required this.goalList,
    required this.goalTitle,
    required this.isMarked,
  });
}
