import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_leaf/model/journal_model/journal_model.dart';

ValueNotifier<List<JournalModel>> journalsNotifier = ValueNotifier([]);

class JournalDb with ChangeNotifier {
  static const String journalDb = "journal_details";

  static Future<void> addJournal(newJournal) async {
    final journalBox = await Hive.openBox<JournalModel>(journalDb);
    final timeKey = DateTime.now().millisecondsSinceEpoch.toString();
    newJournal.journalkey = timeKey;
    await journalBox.put(timeKey, newJournal);
  }

  static Future<void> getjournals() async {
    final getJournalBox = await Hive.openBox<JournalModel>(journalDb);
    journalsNotifier.value.clear();
    journalsNotifier.value = getJournalBox.values.toList();
    journalsNotifier.notifyListeners();
  }

  static Future<void> updateJournal(updatedJournal) async {
    final updateJournalBox = await Hive.openBox<JournalModel>(journalDb);
    String key = updatedJournal.journalkey ?? " ";
    updateJournalBox.put(key, updatedJournal);
    await getjournals();
  }

  static Future<void> deleteJournal(String key) async {
    final deleteJournalbox = await Hive.openBox<JournalModel>(journalDb);
    await deleteJournalbox.delete(key);
    await getjournals();
  }
}
