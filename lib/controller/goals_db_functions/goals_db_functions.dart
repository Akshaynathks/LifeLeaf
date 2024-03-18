// ValueNotifier<List<User>> userNotifier = ValueNotifier([]);

// class UserDb with ChangeNotifier {
//   static const String userDb = "user_details";

//   static Future<void> addUser(User newUser) async {
//     final userBox = await Hive.openBox<User>(userDb);
//     final timeKey = DateTime.now().millisecondsSinceEpoch.toString();
//     newUser.key = timeKey;
//     await userBox.put(timeKey, newUser);
//   }

//   static Future<void> getUser() async {
//     final userBox = await Hive.openBox<User>(userDb);
//     userNotifier.value.clear();
//     userNotifier.value = userBox.values.toList();
//     userNotifier.notifyListeners();
//   }
// }


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
    await goalBox.put(timeKey, newGoal);

  }
    static Future<void> getGoals() async {
    final getGoalBox = await Hive.openBox<GoalsMainModel>(goalDb);
    goalsNotifier.value.clear();
    goalsNotifier.value = getGoalBox.values.toList();
    goalsNotifier.notifyListeners();
  } 

   static Future<void> deleteGoal(String key) async {
    final deleteGoalBox = await Hive.openBox<GoalsMainModel>(goalDb);
    await deleteGoalBox.delete(key);
    await getGoals();
  }
}
