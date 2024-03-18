
import 'package:hive_flutter/hive_flutter.dart';
part 'journal_model.g.dart';

@HiveType(typeId: 3)
class JournalModel {
  @HiveField(0)
  String? journalTitle;
  @HiveField(1)
  String journalNotes;
  @HiveField(2)
  String? journalkey;
  @HiveField(3)
  String? journalDate;
  @HiveField(4)
  List<String?> images;

  JournalModel(
      {this.journalkey,
      required this.journalTitle,
      required this.journalNotes,
      required this.journalDate,
      required this.images
      });
}
