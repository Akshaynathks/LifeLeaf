
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';

ValueNotifier<List<GoalsMainModel>> goalsNotifier = ValueNotifier([]);

class GoalDb with ChangeNotifier {
  static const String goalDb = "goal_details";

  static Future<void> addGoal(GoalsMainModel newGoal) async {
    final goalBox = await Hive.openBox<GoalsMainModel>(goalDb);
    final timeKey = DateTime.now().millisecondsSinceEpoch.toString();
    newGoal.key = timeKey;
    for (int i = 0; i < newGoal.goalList.length; i++) {
      final stepKey = '${timeKey}_$i'; // Concatenate timeKey with step index
      newGoal.goalList[i].key = stepKey;
    }
    await goalBox.put(timeKey, newGoal);
  }

  static Future<void> getGoals() async {
    final getGoalBox = await Hive.openBox<GoalsMainModel>(goalDb);
    goalsNotifier.value.clear();
    goalsNotifier.value = getGoalBox.values.toList();
    goalsNotifier.notifyListeners();
  }

  static Future<void> updateGoal(GoalsMainModel updatedGoal) async {
    final updateGoalBox = await Hive.openBox<GoalsMainModel>(goalDb);
    String key = updatedGoal.key ?? " ";
    updateGoalBox.put(key, updatedGoal);
    await getGoals();
  }

  static Future<void> deleteGoal(String key) async {
    final deleteGoalBox = await Hive.openBox<GoalsMainModel>(goalDb);
    await deleteGoalBox.delete(key);
    await getGoals();
  }

  static Future<void> deleteGoalStep(String key) async {
    final deleteGoalStepBox = await Hive.openBox<GoalsMainModel>(goalDb);
    await deleteGoalStepBox.delete(key);
    await getGoals();
  }
}
