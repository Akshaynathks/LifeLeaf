import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:life_leaf/model/reminder_model/reminder_model.dart';

ValueNotifier<List<ReminderModel>> reminderNotifier = ValueNotifier([]);

class ReminderDb with ChangeNotifier {
  static const String reminderDb = "reminder_details";

  static Future<void> addReminder(ReminderModel newReminder) async {
    final reminderBox = await Hive.openBox<ReminderModel>(reminderDb);
    final timeKey = DateTime.now().millisecondsSinceEpoch.toString();
    newReminder.rkey = timeKey;
    await reminderBox.put(timeKey, newReminder);
  }

  static Future<void> getReminder() async {
    final getReminderBox = await Hive.openBox<ReminderModel>(reminderDb);
    reminderNotifier.value.clear();
    reminderNotifier.value = getReminderBox.values.toList();
    reminderNotifier.notifyListeners();
  }

  static Future<void> updateReminder(updatedReminder) async {
    final updateReminderBox = await Hive.openBox<ReminderModel>(reminderDb);
    String key = updatedReminder.mkey ?? " ";
    updateReminderBox.put(key, updatedReminder);
    await getReminder();
  }

  static Future<void> deleteReminder(String key) async {
    final deleteReminderbox = await Hive.openBox<ReminderModel>(reminderDb);
    await deleteReminderbox.delete(key);
    await getReminder();
  }
}
