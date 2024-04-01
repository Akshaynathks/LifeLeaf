import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:life_leaf/model/habit_model/habit_model.dart';

ValueNotifier<List<HabitModel>> habitNotifier = ValueNotifier([]);

class HabitDb with ChangeNotifier {
  static const String habitDb = "habit_details";

  static Future<void> addHabit(HabitModel newHabit) async {
    final habitBox = await Hive.openBox<HabitModel>(habitDb);
    final timeKey = DateTime.now().millisecondsSinceEpoch.toString();
    newHabit.hkey = timeKey;
    await habitBox.put(timeKey, newHabit);
  }

  static Future<void> getHabit() async {
    final getHabitBox = await Hive.openBox<HabitModel>(habitDb);
    habitNotifier.value.clear();
    habitNotifier.value = getHabitBox.values.toList();
    habitNotifier.notifyListeners();
  }

  static Future<void> updateHabit(HabitModel updatedHabit) async {
    final updateHabitBox = await Hive.openBox<HabitModel>(habitDb);
    String key = updatedHabit.hkey ?? " ";
    updateHabitBox.put(key, updatedHabit);
    await getHabit();
  }

  static Future<void> deleteHabit(String key) async {
    final deleteHabitbox = await Hive.openBox<HabitModel>(habitDb);
    await deleteHabitbox.delete(key);
    await getHabit();
  }
}
