import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';

ValueNotifier<List<MemoriesModel>> memoriesNotifier = ValueNotifier([]);

class MemoriesDb with ChangeNotifier {
  static const String memoriesDb = "memories_details";

  static Future<void> addMemories(MemoriesModel newMemories) async {
    final memoriesBox = await Hive.openBox<MemoriesModel>(memoriesDb);
    final timeKey = DateTime.now().millisecondsSinceEpoch.toString();
    newMemories.mkey = timeKey;
    await memoriesBox.put(timeKey, newMemories);
  }

  static Future<void> getMemories() async {
    final getMemoryBox = await Hive.openBox<MemoriesModel>(memoriesDb);
    memoriesNotifier.value.clear();
    memoriesNotifier.value = getMemoryBox.values.toList();
    memoriesNotifier.notifyListeners();
  }

  static Future<void> updateMemories(updatedMemories) async {
    final updateMemoriesBox = await Hive.openBox<MemoriesModel>(memoriesDb);
    String key = updatedMemories.mkey ?? " ";
    updateMemoriesBox.put(key, updatedMemories);
    await getMemories();
  }

  static Future<void> deleteMemories(String key) async {
    final deleteMemoriesbox = await Hive.openBox<MemoriesModel>(memoriesDb);
    await deleteMemoriesbox.delete(key);
    await getMemories();
  }
}
